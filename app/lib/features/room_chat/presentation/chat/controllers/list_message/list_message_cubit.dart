import 'dart:async';
import 'dart:io';

import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_message_chat_room_uc.dart';
import 'package:app/features/room_chat/domain/usecases/send_message_uc.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_profile_local_uc.dart';
import 'package:app/service/firebase/upload_file_exts.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utilities/utilities.dart';
import 'package:uuid/uuid.dart';

part 'list_message_cubit.freezed.dart';
part 'list_message_state.dart';

@Injectable()
class ListMessageCubit extends Cubit<ListMessageState> {
  late final GetUserProfileLocalUseCase _getUserProfileLocalUseCase;
  late final GetListMessageChatRoomUseCase _getListMessageChatRoomUseCase;
  late final SendMessageUseCase _sendMessageUseCase;

  ListMessageCubit(this._getUserProfileLocalUseCase, this._sendMessageUseCase,
      this._getListMessageChatRoomUseCase)
      : super(const ListMessageState.initial()) {
    _subGetNewMessage =
        _sendMessageUseCase.getNewMessageStream().listen((messageModel) {
      if (messageModel.netData != null) {
        Logs.e(messageModel.netData);
        _onReceiveNewMessage(messageModel.netData!);
      }
    });
  }

  late final StreamSubscription<AppObjResultModel<IMessageModel>>
      _subGetNewMessage;

  @override
  Future<void> close() {
    _subGetNewMessage.cancel();
    return super.close();
  }

  Future<void> initPage(String roomId) async {
    try {
      emit(state.copyWith(isLoading: true, roomId: roomId));
      final userResponse = await _getUserProfileLocalUseCase.executeObj();
      final listMessageResponse =
          await _getListMessageChatRoomUseCase.executeList(
              request: GetListRoomMessageParam(chatRoomId: roomId, limit: 20));

      final listMessage = listMessageResponse.netData;

      if (listMessage != null && listMessage.isNotEmpty) {
        final indexStartedCall = listMessage.indexWhere((message) =>
            message is SystemMessageModel &&
            message.systemMessage == SystemContent.callStarted);
        final indexEndCall = listMessage.indexWhere((message) =>
            message is SystemMessageModel &&
            message.systemMessage == SystemContent.callEnded);

        if (indexEndCall != -1 &&
            indexEndCall != -1 &&
            indexStartedCall < indexEndCall) {
          emit(state.copyWith(isCalling: true));
        }
      }

      emit(state.copyWith(
        currentUser: userResponse.netData,
        listMessage: listMessageResponse.netData ?? [],
        nextOffset: listMessageResponse.next,
      ));
      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  void _onReceiveNewMessage(IMessageModel newMessage) {
    if (newMessage.roomId == state.roomId) {
      if (newMessage is SystemMessageModel) {
        if (newMessage.systemMessage == SystemContent.callStarted) {
          emit(state.copyWith(isCalling: true));
        }
        if (newMessage.systemMessage == SystemContent.callEnded) {
          emit(state.copyWith(isCalling: false));
        }
      }
      if (newMessage.clientId != null) {
        List<IMessageModel> currentListMessage = List.from(state.listMessage);
        currentListMessage
            .removeWhere((message) => message.clientId == newMessage.clientId);
        emit(state.copyWith(listMessage: [newMessage, ...currentListMessage]));
      } else {
        emit(state.copyWith(listMessage: [newMessage, ...state.listMessage]));
      }
    }
  }

  Future<void> getMessagesTopPage() async {
    try {
      if (state.nextOffset == null || state.nextOffset == '') {
        return;
      }

      final currentListMessage = state.listMessage;

      final listMessageResponse =
          await _getListMessageChatRoomUseCase.executeList(
        request: GetListRoomMessageParam(
          chatRoomId: state.roomId,
          offset: state.nextOffset!,
          limit: 15,
        ),
      );

      final bool isLastPage =
          (listMessageResponse.next == null || listMessageResponse.next == '');

      final List<IMessageModel> newListMessage = List.from(currentListMessage)
        ..addAll(listMessageResponse.netData ?? []);

      emit(state.copyWith(
        listMessage: newListMessage,
        isLastPage: isLastPage,
        nextOffset: listMessageResponse.next,
      ));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  // Future<void> getMessagesBottomPage() async {
  //   try {
  //     final currentListMessage = state.listMessage;

  //     final listMessageResponse =
  //         await _getListMessageChatRoomUseCase.executeList(
  //       request: GetListRoomMessageParam(
  //         chatRoomId: state.roomId,
  //         offset: currentListMessage.first.id,
  //         order: MessageOrder.asc.value,
  //       ),
  //     );

  //     final bool isFirstPage =
  //         (listMessageResponse.netData?.length ?? 0) < limitMessage;

  //     final List<IMessageModel> newListMessage = [
  //       ...listMessageResponse.netData?.reversed ?? [],
  //       ...currentListMessage
  //     ];

  //     emit(state.copyWith(
  //         listMessage: newListMessage, isFirstPage: isFirstPage));
  //   } on AppException catch (e) {
  //     AppExceptionExt(
  //         appException: e,
  //         onError: (_) {
  //           Logs.e(e);
  //         }).detected();
  //   }
  // }

  void sendTextMessage(TextMessageParam message) async {
    try {
      final repliedMessage = state.tempRepliedMessage;
      TextMessageParam params = message;
      if (repliedMessage != null) {
        params = message.copyWith(
          repliedMessage:
              ReplyMessageParam.convert2ReplyMessageParam(repliedMessage),
        );
      }

      final messageParams =
          SocketMessageParam.convert2SocketMessageParam(params, state.roomId);

      _sendMessageUseCase.executeObj(request: messageParams);

      emit(state.copyWith(tempRepliedMessage: null));
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  void sendMapMessage(MapMessageParam message) async {
    try {
      final messageParams =
          SocketMessageParam.convert2SocketMessageParam(message, state.roomId);
      _sendMessageUseCase.executeObj(request: messageParams);
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  void sendEmojiMessage(EmojiMessageParam message) async {
    try {
      final messageParams =
          SocketMessageParam.convert2SocketMessageParam(message, state.roomId);
      _sendMessageUseCase.executeObj(request: messageParams);
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendImageMessage(ImageMessageParam message) async {
    try {
      //create temp message
      final messageParam = message.copyWith(clientId: const Uuid().v4());
      if (state.currentUser != null) {
        final tempMessage = ImageMessageModel.getTextMessageModelFromParam(
            messageParam, state.currentUser!, state.roomId);

        emit(state.copyWith(listMessage: [tempMessage, ...state.listMessage]));

        final imageUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            messageParam.uri, TypeFile.images.type);
        if (imageUrl != null) {
          final imageMessageParams = messageParam.copyWith(uri: imageUrl);

          final messageParams = SocketMessageParam.convert2SocketMessageParam(
              imageMessageParams, state.roomId);
          _sendMessageUseCase.executeObj(request: messageParams);
        }
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendFileMessage(FileMessageParam message) async {
    try {
      //create temp message
      final messageParam = message.copyWith(clientId: const Uuid().v4());
      if (state.currentUser != null) {
        final tempMessage = FileMessageModel.getFileMessageModelFromParam(
            messageParam, state.currentUser!, state.roomId);

        emit(state.copyWith(listMessage: [tempMessage, ...state.listMessage]));

        final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            messageParam.uri, TypeFile.files.type);
        if (fileUrl != null) {
          final fileMessageParams = messageParam.copyWith(uri: fileUrl);

          final messageParams = SocketMessageParam.convert2SocketMessageParam(
              fileMessageParams, state.roomId);
          _sendMessageUseCase.executeObj(request: messageParams);
        }
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendAudioMessage(AudioMessageParam message) async {
    try {
      if (state.currentUser != null) {
        final messageParam = message.copyWith(clientId: const Uuid().v4());
        final tempMessage = AudioMessageModel.getAudioMessageModelFromParam(
            messageParam, state.currentUser!, state.roomId);

        emit(state.copyWith(listMessage: [tempMessage, ...state.listMessage]));

        final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            messageParam.uri, TypeFile.audios.type);
        if (fileUrl != null) {
          final fileMessageParams = messageParam.copyWith(uri: fileUrl);

          final messageParams = SocketMessageParam.convert2SocketMessageParam(
              fileMessageParams, state.roomId);
          _sendMessageUseCase.executeObj(request: messageParams);
        }
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendVideoMessage(VideoMessageParam message) async {
    try {
      if (state.currentUser != null) {
        //create temp message
        final messageParam = message.copyWith(clientId: const Uuid().v4());
        final tempMessage = VideoMessageModel.getVideoMessageModelFromParam(
            messageParam, state.currentUser!, state.roomId);

        emit(state.copyWith(listMessage: [tempMessage, ...state.listMessage]));

        String? thumbnailUrl = messageParam.thumbnailUrl;
        if (messageParam.thumbnailUrl != null) {
          thumbnailUrl = await UploadFileExts.uploadAndDownloadUrlFile(
              messageParam.thumbnailUrl!, TypeFile.images.type);
        }
        final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            messageParam.uri, TypeFile.videos.type);
        if (fileUrl != null) {
          final fileMessageParams = messageParam.copyWith(
            uri: fileUrl,
            thumbnailUrl: thumbnailUrl ?? messageParam.thumbnailUrl,
          );

          final messageParams = SocketMessageParam.convert2SocketMessageParam(
              fileMessageParams, state.roomId);
          _sendMessageUseCase.executeObj(request: messageParams);
        }
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  void previewDataFetched(
      TextMessageModel textMessage, PreviewDataModel previewData) {
    var currentListMessage = state.listMessage.toList();
    final index = currentListMessage
        .indexWhere((element) => element.id == textMessage.id);
    final updatedMessage =
        (currentListMessage[index] as TextMessageModel).copyWith(
      previewData: previewData,
    );

    currentListMessage[index] = updatedMessage;
    emit(state.copyWith(listMessage: [...currentListMessage]));
  }

  Future<void> handleMessageTap(IMessageModel message) async {
    if (message is FileMessageModel) {
      var localPath = message.uri;

      int index = -1;
      var currentListMessage = state.listMessage.toList();

      if (message.uri.startsWith('http')) {
        try {
          index = currentListMessage
              .indexWhere((element) => element.id == message.id);

          final updatedMessage = (currentListMessage[index] as FileMessageModel)
              .copyWith(isLoading: true);

          currentListMessage[index] = updatedMessage;

          emit(state.copyWith(listMessage: [...currentListMessage]));

          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            final client = http.Client();
            final request = await client.get(Uri.parse(message.uri));
            final bytes = request.bodyBytes;
            await file.writeAsBytes(bytes);
          }
        } finally {
          if (index != -1) {
            final updatedMessage =
                (currentListMessage[index] as FileMessageModel)
                    .copyWith(isLoading: false);
            currentListMessage[index] = updatedMessage;
            emit(state.copyWith(listMessage: [...currentListMessage]));
          }
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void addTempRepliedMessage(IMessageModel? message) {
    emit(state.copyWith(tempRepliedMessage: message));
  }
}

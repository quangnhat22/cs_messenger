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
      final listMessageResponse = await _getListMessageChatRoomUseCase
          .executeList(request: GetListRoomMessageParam(chatRoomId: roomId));
      emit(state.copyWith(
          currentUser: userResponse.netData,
          listMessage: listMessageResponse.netData ?? []));
      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> _getListMessages() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      List<IMessageModel> _messages = [
        TextMessageModel(
          id: '1',
          author: UserModel(id: '1'),
          content: '123',
          type: MessageType.text,
          createdAt: DateTime.now(),
          isMe: true,
          roomId: state.roomId,
        ),
        TextMessageModel(
          id: '2',
          author: UserModel(id: '1'),
          content: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          roomId: state.roomId,
          type: MessageType.text,
          createdAt: DateTime.now(),
          previewData: PreviewDataModel(
            title: 'hihi',
            description: '12122',
            link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
            image:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          ),
        ),
        ImageMessageModel(
          id: '3',
          author: UserModel(id: '2'),
          roomId: state.roomId,
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.image,
          createdAt: DateTime.now(),
        ),
        SystemMessageModel(
          id: '4',
          content: 'Hello',
          author: UserModel(id: '2'),
          type: MessageType.system,
          createdAt: DateTime.now(),
          roomId: state.roomId,
        ),
        ImageMessageModel(
          id: '5',
          author: UserModel(id: '2'),
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.image,
          roomId: state.roomId,
          createdAt: DateTime.now(),
        ),
        FileMessageModel(
          id: '6',
          author: UserModel(id: '2'),
          name: 'city-guide-image1872y1772717627627.png',
          roomId: state.roomId,
          size: 18278,
          content:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          uri:
              'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          type: MessageType.file,
          isLoading: true,
        ),
        AudioMessageModel(
          id: '7',
          roomId: state.roomId,
          author: UserModel(id: '2'),
          name: 'city-guide-image1872y1772717627627.png',
          content:
              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          uri:
              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          type: MessageType.audio,
        ),
        MapMessageModel(
          id: '8',
          author: UserModel(id: '2'),
          roomId: state.roomId,
          lat: 37.4219983,
          long: -122.084,
          name:
              "P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States",
          content:
              'P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States',
          type: MessageType.map,
        ),
      ];
      emit(state.copyWith(listMessage: _messages));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  void _onReceiveNewMessage(IMessageModel newMessage) {
    if (newMessage.roomId == state.roomId) {
      emit(state.copyWith(listMessage: [newMessage, ...state.listMessage]));
    }
  }

  Future<void> getMessagesTopPage() async {
    try {
      if (!state.isLastPage) {
        List<IMessageModel> _messages = [
          TextMessageModel(
            id: '11',
            author: UserModel(id: '1'),
            content: '123',
            type: MessageType.text,
            createdAt: DateTime.now(),
            isMe: true,
            roomId: state.roomId,
          ),
          TextMessageModel(
            id: '12',
            author: UserModel(id: '1'),
            content: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
            roomId: state.roomId,
            type: MessageType.text,
            createdAt: DateTime.now(),
            previewData: PreviewDataModel(
              title: 'hihi',
              description: '12122',
              link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
              image:
                  'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            ),
          ),
          ImageMessageModel(
            id: '13',
            author: UserModel(id: '2'),
            roomId: state.roomId,
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.image,
            createdAt: DateTime.now(),
          ),
          SystemMessageModel(
            id: '14',
            content: 'Hello',
            author: UserModel(id: '2'),
            type: MessageType.system,
            createdAt: DateTime.now(),
            roomId: state.roomId,
          ),
          ImageMessageModel(
            id: '15',
            author: UserModel(id: '2'),
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.image,
            roomId: state.roomId,
            createdAt: DateTime.now(),
          ),
          FileMessageModel(
            id: '16',
            author: UserModel(id: '2'),
            name: 'city-guide-image1872y1772717627627.png',
            roomId: state.roomId,
            size: 18278,
            content:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            uri:
                'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
            type: MessageType.file,
            isLoading: true,
          ),
          AudioMessageModel(
            id: '17',
            roomId: state.roomId,
            author: UserModel(id: '2'),
            name: 'city-guide-image1872y1772717627627.png',
            content:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            uri:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            type: MessageType.audio,
          ),
          MapMessageModel(
            id: '18',
            author: UserModel(id: '2'),
            roomId: state.roomId,
            lat: 37.4219983,
            long: -122.084,
            name:
                "P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States",
            content:
                'P1600 Amphitheatre Pkwy, Amphitheatre Parkway ,Mountain View, California, United States',
            type: MessageType.map,
          ),
        ];
        emit(state.copyWith(
          listMessage: [...state.listMessage, ..._messages],
          isLastPage: true,
        ));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> getMessagesBottomPage() async {
    try {
      if (!state.isFirstPage) {
        List<IMessageModel> _messages = [
          // TextMessageModel(
          //   id: '21',
          //   author: UserModel(id: '1'),
          //   text: '123',
          //   type: MessageType.text,
          //   createdAt: DateTime.now(),
          // ),
          // TextMessageModel(
          //   id: '22',
          //   author: UserModel(id: '1'),
          //   text: '123 https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          //   type: MessageType.text,
          //   createdAt: DateTime.now(),
          //   previewData: PreviewDataModel(
          //     title: 'hihi',
          //     description: '12122',
          //     link: 'https://source.unsplash.com/WBGjg0DsO_g/1920x1280',
          //     image:
          //         'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   ),
          // ),
          // ImageMessageModel(
          //   id: '23',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF9C7kSBmqY1lRviFkXxR_SuCnKPDFOe_mpQ0n3ytO-rgD1Rm8xGRPtMQsubE-wsVwnb4&usqp=CAU',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // SystemMessageModel(
          //   id: '24',
          //   text: 'Hello',
          //   author: UserModel(id: '2'),
          //   type: MessageType.system,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '25',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '26',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          //   createdAt: DateTime.now(),
          // ),
          // ImageMessageModel(
          //   id: '27',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF9C7kSBmqY1lRviFkXxR_SuCnKPDFOe_mpQ0n3ytO-rgD1Rm8xGRPtMQsubE-wsVwnb4&usqp=CAU',
          //   type: MessageType.image,
          // ),
          // ImageMessageModel(
          //   id: '28',
          //   author: UserModel(id: '2'),
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.image,
          // ),
          // FileMessageModel(
          //   id: '29',
          //   author: UserModel(id: '2'),
          //   name: 'city-guide-image1872y1772717627627.png',
          //   size: 18278,
          //   uri:
          //       'https://media.istockphoto.com/id/1184692500/vi/anh/ho%C3%A0ng-h%C3%B4n-r%E1%BB%B1c-r%E1%BB%A1-s%E1%BA%AFc-m%C3%A0u-t%E1%BA%A1i-h%E1%BB%93-davis.jpg?s=2048x2048&w=is&k=20&c=7_nKoJfpTHairg8iam7eYhhq99EcBa42xOIq56mJIRI=',
          //   type: MessageType.file,
          //   isLoading: true,
          // ),
          // AudioMessageModel(
          //   id: '30',
          //   author: UserModel(id: '2'),
          //   name: 'city-guide-image1872y1772717627627.png',
          //   uri:
          //       'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
          //   type: MessageType.audio,
          // ),
        ];
        emit(state.copyWith(
          listMessage: [..._messages, ...state.listMessage],
          isFirstPage: true,
        ));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e);
          }).detected();
    }
  }

  void sendTextMessage(TextMessageParam message) async {
    try {
      final messageParams =
          SocketMessageParam.convert2SocketMessageParam(message, state.roomId);
      _sendMessageUseCase.executeObj(request: messageParams);
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
      final imageUrl = await UploadFileExts.uploadAndDownloadUrlFile(
          message.uri, TypeFile.images.type);
      if (imageUrl != null) {
        final imageMessageParams = message.copyWith(uri: imageUrl);

        final messageParams = SocketMessageParam.convert2SocketMessageParam(
            imageMessageParams, state.roomId);
        _sendMessageUseCase.executeObj(request: messageParams);
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendFileMessage(FileMessageParam message) async {
    try {
      final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
          message.uri, TypeFile.files.type);
      if (fileUrl != null) {
        final fileMessageParams = message.copyWith(uri: fileUrl);

        final messageParams = SocketMessageParam.convert2SocketMessageParam(
            fileMessageParams, state.roomId);
        _sendMessageUseCase.executeObj(request: messageParams);
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendAudioMessage(AudioMessageParam message) async {
    try {
      final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
          message.uri, TypeFile.audios.type);
      if (fileUrl != null) {
        final fileMessageParams = message.copyWith(uri: fileUrl);

        final messageParams = SocketMessageParam.convert2SocketMessageParam(
            fileMessageParams, state.roomId);
        _sendMessageUseCase.executeObj(request: messageParams);
      }
    } on AppException catch (e) {
      Logs.e(e);
    }
  }

  Future<void> sendVideoMessage(VideoMessageParam message) async {
    try {
      String? thumbnailUrl = message.thumbnailUrl;
      if (message.thumbnailUrl != null) {
        thumbnailUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            message.thumbnailUrl!, TypeFile.images.type);
      }
      final fileUrl = await UploadFileExts.uploadAndDownloadUrlFile(
          message.uri, TypeFile.videos.type);
      if (fileUrl != null) {
        final fileMessageParams = message.copyWith(
          uri: fileUrl,
          thumbnailUrl: thumbnailUrl ?? message.thumbnailUrl,
        );

        final messageParams = SocketMessageParam.convert2SocketMessageParam(
            fileMessageParams, state.roomId);
        _sendMessageUseCase.executeObj(request: messageParams);
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
}

import 'dart:async';

import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_chat_room_uc.dart';
import 'package:app/features/room_chat/domain/usecases/send_message_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class ListChatRoomCubit extends AppListViewCubit<ChatRoomModel> {
  late final GetListChatRoomUseCase _getListChatRoomUseCase;
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;
  late final SendMessageUseCase _sendMessageUseCase;

  ListChatRoomCubit(this._getListChatRoomUseCase,
      this._getChatRoomDetailInfoUseCase, this._sendMessageUseCase) {
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

  @override
  Future<AppListResultModel<ChatRoomModel>> onCall(AppParam appParam) async {
    return _getListChatRoomUseCase.executeList(
      request: GetListChatRoomParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }

  void _onReceiveNewMessage(IMessageModel newMessage) async {
    try {
      List<ChatRoomModel> currentListChatRoom = List.from(state.data);

      final indexChatRoom = currentListChatRoom
          .indexWhere((element) => element.id == newMessage.roomId);

      if (indexChatRoom != -1) {
        currentListChatRoom.removeAt(indexChatRoom);
      }

      final messageChatRoom = await _getChatRoomDetailInfoUseCase.executeObj(
          request: GetChatRoomInfoParam(id: newMessage.roomId));

      final chatRoomUpdated =
          messageChatRoom.netData?.copyWith(isHasNewMessage: true);

      if (messageChatRoom.netData != null) {
        currentListChatRoom.insert(0, chatRoomUpdated!);
        emit(state.copyWith(data: [...currentListChatRoom]));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  void removeNewMessageStatus(String chatRoomId) {
    List<ChatRoomModel> currentListChatRoom = List.from(state.data);
    final indexChatRoom = currentListChatRoom.indexWhere(
        (element) => element.id == chatRoomId && element.isHasNewMessage);
    if (indexChatRoom != -1) {
      currentListChatRoom[indexChatRoom] =
          currentListChatRoom[indexChatRoom].copyWith(isHasNewMessage: false);
      emit(state.copyWith(data: [...currentListChatRoom]));
    }
  }
}

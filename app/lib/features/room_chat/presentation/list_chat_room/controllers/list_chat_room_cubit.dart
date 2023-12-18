import 'dart:async';

import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_chat_room_uc.dart';
import 'package:app/features/room_chat/domain/usecases/send_message_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class ListChatRoomCubit extends AppListViewCubit<ChatRoomModel> {
  late final GetListChatRoomUseCase _getListFriendUseCase;
  late final SendMessageUseCase _sendMessageUseCase;

  ListChatRoomCubit(this._getListFriendUseCase, this._sendMessageUseCase) {
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
    return _getListFriendUseCase.executeList(
      request: GetListChatRoomParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }

  void _onReceiveNewMessage(IMessageModel newMessage) async {
    await onRefreshCall();
  }
}

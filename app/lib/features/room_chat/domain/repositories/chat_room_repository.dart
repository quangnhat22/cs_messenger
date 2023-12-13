import 'package:domain/domain.dart';

abstract class ChatRoomRepository {
  Future<AppListResultModel<ChatRoomModel>> getListChatRoom(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<ChatRoomModel>> getChatRoomInfo(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> updateChatRoomInfo(
      {required Map<String, dynamic> query});
}

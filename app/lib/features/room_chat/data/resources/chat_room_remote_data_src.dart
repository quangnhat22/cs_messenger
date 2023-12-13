import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class ChatRoomRemoteDataSource {
  Future<AppListResultRaw<ChatRoomRaw>> fetchListChatRoom(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<ChatRoomRaw>> getChatRoomInfo(
      {required Map<String, dynamic> query});

  //todo: remove it
  Future<AppObjResultRaw<EmptyRaw>> updateGroupChatRoomInfo(
      {required Map<String, dynamic> query});

  Future<AppListResultRaw<MessageRaw>> getListMessages(
      {required Map<String, dynamic> query});
}

@Injectable(as: ChatRoomRemoteDataSource)
class ChatRoomRemoteDataSourceImpl extends ChatRoomRemoteDataSource {
  late final NetworkService _service;

  ChatRoomRemoteDataSourceImpl(this._service);

  @override
  Future<AppObjResultRaw<ChatRoomRaw>> getChatRoomInfo(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.group,
          method: HttpMethod.post,
          body: query,
        ),
      );
      return response.toRaw((_) => ChatRoomRaw(id: '-1', roomId: '1'));
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultRaw<ChatRoomRaw>> fetchListChatRoom(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.chatRoom,
          method: HttpMethod.get,
          query: query,
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => ChatRoomRaw.fromJson(item))
          .toList());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> updateGroupChatRoomInfo(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.group,
          method: HttpMethod.post,
          body: query,
        ),
      );
      return response.toRaw((_) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultRaw<MessageRaw>> getListMessages(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.chatRoomMessageById(query['id']),
          method: HttpMethod.post,
          body: query,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => MessageRaw.fromJson(item))
          .toList());
    } on AppException catch (_) {
      rethrow;
    }
  }
}

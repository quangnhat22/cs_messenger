import 'package:app/features/room_chat/data/resources/chat_room_remote_data_src.dart';
import 'package:app/features/room_chat/domain/repositories/chat_room_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRoomRepository)
class ChatRoomRepositoryImpl extends ChatRoomRepository {
  late final ChatRoomRemoteDataSource _chatRoomRemoteDataSource;

  ChatRoomRepositoryImpl(this._chatRoomRemoteDataSource);

  @override
  Future<AppObjResultModel<ChatRoomModel>> getChatRoomInfo(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<ChatRoomRaw> remoteData =
          await _chatRoomRemoteDataSource.getChatRoomInfo(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateChatRoomInfo(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _chatRoomRemoteDataSource.updateGroupChatRoomInfo(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<ChatRoomModel>> getListChatRoom(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<ChatRoomRaw> remoteData =
          await _chatRoomRemoteDataSource.fetchListChatRoom(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

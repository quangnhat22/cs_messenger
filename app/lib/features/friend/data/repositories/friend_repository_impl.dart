import 'package:app/features/friend/data/resources/friend_remote_data_source.dart';
import 'package:app/features/friend/domain/repositories/friend_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FriendRepository)
class FriendRepositoryImpl extends FriendRepository {
  final FriendRemoteDataSource _remote;

  FriendRepositoryImpl(this._remote);

  @override
  Future<AppListResultModel<HistoryCallModel>> getListCallHistory(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<HistoryCallRaw> remoteData =
          await _remote.fetchListCallHistory(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<UserModel>> getListFriend(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<UserRaw> remoteData =
          await _remote.fetchListFriend(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> deleteFriendRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.deleteFriend(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

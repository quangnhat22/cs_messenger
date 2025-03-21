import 'package:app/features/group/data/resources/group_remote_data_source.dart';
import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GroupRepository)
class GroupRepositoryImpl extends GroupRepository {
  final GroupRemoteDataSource _remote;

  GroupRepositoryImpl(this._remote);

  @override
  Future<AppListResultModel<GroupModel>> getListGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<GroupRaw> remoteData =
          await _remote.fetchListGroup(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> createNewGroup(
      {required Map<String, dynamic> request}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.createNewGroup(query: request);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<UserModel>> getListMemberGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<UserRaw> remoteData =
          await _remote.fetchListMemberGroup(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> editGroup(
      {required Map<String, dynamic> request, required String groupId}) async {
    try {
      request.removeWhere((key, value) => value == null || value == '');
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.editGroup(query: request, groupId: groupId);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> leaveGroup(
      {required Map<String, dynamic> request}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.leaveGroup(query: request);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

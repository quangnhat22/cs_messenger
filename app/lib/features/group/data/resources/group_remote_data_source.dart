import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GroupRemoteDataSource {
  Future<AppListResultRaw<GroupRaw>> fetchListGroup(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> createNewGroup(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> leaveGroup(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> editGroup(
      {required Map<String, dynamic> query, required String groupId});
}

@Injectable(as: GroupRemoteDataSource)
class FriendRemoteDataSourceImpl extends GroupRemoteDataSource {
  late final NetworkService _service;

  FriendRemoteDataSourceImpl(this._service);

  @override
  Future<AppListResultRaw<GroupRaw>> fetchListGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.group,
          method: HttpMethod.get,
          query: query,
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => GroupRaw.fromJson(item))
          .toList());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> createNewGroup(
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
  Future<AppObjResultRaw<EmptyRaw>> leaveGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.groupById(query['groupId']),
          method: HttpMethod.delete,
        ),
      );
      return response.toRaw((_) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> editGroup(
      {required Map<String, dynamic> query, required String groupId}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
            url: ApiProvider.groupById(groupId),
            method: HttpMethod.patch,
            body: {...query}),
      );
      return response.toRaw((_) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }
}

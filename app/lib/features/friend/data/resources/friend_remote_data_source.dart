import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class FriendRemoteDataSource {
  Future<AppListResultRaw<HistoryCallRaw>> fetchListCallHistory(
      {required Map<String, dynamic> query});

  Future<AppListResultRaw<UserRaw>> fetchListFriend(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> deleteFriend(
      {required Map<String, dynamic> query});
}

@Injectable(as: FriendRemoteDataSource)
class FriendRemoteDataSourceImpl extends FriendRemoteDataSource {
  late final NetworkService _service;

  FriendRemoteDataSourceImpl(this._service);

  @override
  Future<AppListResultRaw<HistoryCallRaw>> fetchListCallHistory(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.friendCallHistory,
          method: HttpMethod.get,
          query: {...query},
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => HistoryCallRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultRaw<UserRaw>> fetchListFriend(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.friend,
          method: HttpMethod.get,
          query: {...query},
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => UserRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> deleteFriend(
      {required Map<String, dynamic> query}) async {
    try {
      await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.friendById(query['id']),
          method: HttpMethod.delete,
        ),
      );
      return AppObjResultRaw(netData: EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }
}

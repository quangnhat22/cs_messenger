import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UserRemoteDataSource {
  Future<AppObjResultRaw<UserRaw>> getSelfInfo();

  Future<AppObjResultRaw<EmptyRaw>> updateSelfInfo(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<UserRaw>> getUserById(
      {required Map<String, dynamic> query});
}

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  late final NetworkService _networkService;

  UserRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppObjResultRaw<UserRaw>> getSelfInfo() async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.userSelfUrl,
          method: HttpMethod.get,
        ),
      );
      return response.toRaw((data) => UserRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<UserRaw>> getUserById(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.userById(query['id']),
          method: HttpMethod.get,
        ),
      );
      return response.toRaw((data) => UserRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> updateSelfInfo(
      {required Map<String, dynamic> body}) async {
    try {
      body.removeWhere((key, value) => value == null);
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.userSelfUrl,
          method: HttpMethod.put,
          body: {...body},
        ),
      );
      return response.toRaw((_) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }
}

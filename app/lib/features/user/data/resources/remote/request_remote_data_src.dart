import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class RequestRemoteDataSource {
  Future<AppListResultRaw<RequestRaw>> getListRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> sendRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> acceptRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> deleteRequest(
      {required Map<String, dynamic> query});
}

@Injectable(as: RequestRemoteDataSource)
class RequestRemoteDataSourceImpl extends RequestRemoteDataSource {
  late final NetworkService _networkService;

  RequestRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppListResultRaw<RequestRaw>> getListRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.request,
          method: HttpMethod.get,
          isRequestForList: true,
          query: {...query},
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => RequestRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> acceptRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.requestById(query['id']),
          method: HttpMethod.post,
        ),
      );
      return response.toRaw((_) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> deleteRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.requestById(query['id']),
          method: HttpMethod.delete,
        ),
      );
      return response.toRaw((_) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> sendRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.request,
          method: HttpMethod.post,
          body: {...query},
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

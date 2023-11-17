import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class BlockRemoteDataSource {
  Future<AppListResultRaw<UserRaw>> getListBlock();

  Future<AppObjResultRaw<EmptyRaw>> blockUser(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> unBlockUser(
      {required Map<String, dynamic> query});
}

@Injectable(as: BlockRemoteDataSource)
class BlockRemoteDataSourceImpl extends BlockRemoteDataSource {
  late final NetworkService _networkService;

  BlockRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppObjResultRaw<EmptyRaw>> blockUser(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
            url: ApiProvider.blockUser,
            method: HttpMethod.post,
            query: {...query}),
      );
      return response.toRaw((_) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> unBlockUser(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
            url: ApiProvider.blockUser,
            method: HttpMethod.delete,
            query: {...query}),
      );
      return response.toRaw((_) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultRaw<UserRaw>> getListBlock() async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.blockUser,
          method: HttpMethod.delete,
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => UserRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

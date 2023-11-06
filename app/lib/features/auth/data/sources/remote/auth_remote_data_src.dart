import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AppObjResultRaw<TokenRaw>> registerNewAccount(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<TokenRaw>> loginUsingFirebaseToken(
      {String? idToken, String? deviceId});
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  late final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppObjResultRaw<TokenRaw>> registerNewAccount(
      {required Map<String, dynamic> body}) {
    // try {
    //   final AppResponse response = await _service.request(
    //     clientRequest: ClientRequest(
    //       url: ApiProvider.friendCallHistory,
    //       method: HttpMethod.get,
    //       query: query,
    //       isRequestForList: true,
    //     ),
    //   );
    //   return response.toRawList((data) => (data as List<dynamic>)
    //       .map((item) => HistoryCallRaw.fromJson(item))
    //       .toList());
    // } on NetworkException catch (_) {
    //   rethr
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultRaw<TokenRaw>> loginUsingFirebaseToken(
      {String? idToken, String? deviceId}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.loginFirebase,
          method: HttpMethod.post,
          body: {
            "id_token": idToken,
            "device_id": deviceId,
          },
        ),
      );
      return response.toRaw((data) => TokenRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

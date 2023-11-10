import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AppObjResultRaw<EmptyRaw>> registerNewAccount(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<TokenRaw>> loginUsingFirebaseToken(
      {String? idToken, String? deviceId});

  Future<AppObjResultRaw<TokenRaw>> loginByEmailAndPassword(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<EmptyRaw>> verifyEmail(String code);

  Future<AppObjResultRaw<EmptyRaw>> forgotPassword(
      {required Map<String, dynamic> body});
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  late final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppObjResultRaw<EmptyRaw>> registerNewAccount(
      {required Map<String, dynamic> body}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.signUpWithEmail,
          method: HttpMethod.post,
          body: body,
        ),
      );
      return response.toRaw((data) => EmptyRaw());
    } on NetworkException catch (e) {
      rethrow;
    }
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

  @override
  Future<AppObjResultRaw<TokenRaw>> loginByEmailAndPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.loginByEmailAndPassword,
          method: HttpMethod.post,
          body: body,
        ),
      );
      return response.toRaw((data) => TokenRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> verifyEmail(String code) async {
    // try {
    //   final AppResponse response = await _networkService.request(
    //     clientRequest: ClientRequest(
    //       url: ApiProvider.verifyEmail,
    //       method: HttpMethod.get,
    //       query: {"code": code},
    //     ),
    //   );
    //   return response.toRaw((data) => EmptyRaw());
    // } on NetworkException catch (_) {
    //   rethrow;
    // }
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> forgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.forgetPassword,
          method: HttpMethod.post,
          body: body,
        ),
      );
      return response.toRaw((data) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

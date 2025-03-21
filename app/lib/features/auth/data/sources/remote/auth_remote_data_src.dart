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

  Future<AppObjResultRaw<EmptyRaw>> forgotPassword(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<EmptyRaw>> requestResendEmail();

  Future<AppObjResultRaw<EmptyRaw>> logOut();

  Future<AppObjResultRaw<StatusVerifyEmailRaw>> checkVerifyEmail();

  Future<AppObjResultRaw<EmptyRaw>> changePassword(
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
    } on AppException catch (e) {
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
    } on AppException catch (_) {
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
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<StatusVerifyEmailRaw>> checkVerifyEmail() async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.verifyEmail,
          method: HttpMethod.get,
        ),
      );
      return response.toRaw((data) => StatusVerifyEmailRaw.fromJson(data));
    } on AppException catch (_) {
      rethrow;
    }
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
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> requestResendEmail() async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.requestResendEmail,
          method: HttpMethod.post,
        ),
      );
      return response.toRaw((data) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> logOut() async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.logOut,
          method: HttpMethod.delete,
        ),
      );
      return response.toRaw((data) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> changePassword(
      {required Map<String, dynamic> body}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
            url: ApiProvider.changePassword,
            method: HttpMethod.put,
            body: {...body}),
      );
      return response.toRaw((data) => EmptyRaw());
    } on AppException catch (_) {
      rethrow;
    }
  }
}

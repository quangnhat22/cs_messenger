import 'package:app/features/auth/data/sources/firebase/auth_firebase_data_source.dart';
import 'package:app/features/auth/data/sources/local/auth_local_data_src.dart';
import 'package:app/features/auth/data/sources/local/device_info_local_data_src.dart';
import 'package:app/features/auth/data/sources/remote/auth_remote_data_src.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  late final AuthFirebaseDataSource _authFirebaseDataSource;
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final AuthLocalDataSource _authLocalDataSource;
  late final DeviceInfoLocalDataSource _deviceInfoLocalDataSource;

  AuthRepositoryImpl(
    this._authFirebaseDataSource,
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._deviceInfoLocalDataSource,
  );

  @override
  Future<AppObjResultModel<TokenModel>> getTokenFromLocal() async {
    try {
      final tokenRaw = await _authLocalDataSource.getToken();
      return tokenRaw.raw2Model();
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> forceLogOut() async {
    try {
      await _authLocalDataSource.clearToken();
      return AppObjResultModel(netData: EmptyModel());
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithGoogle() async {
    try {
      final userCredential = await _authFirebaseDataSource.signInWithGoogle();
      final idToken = await userCredential.user?.getIdToken();
      if (idToken != null) {
        final deviceId = await _deviceInfoLocalDataSource.getDeviceId();

        final remoteData = await _authRemoteDataSource.loginUsingFirebaseToken(
            idToken: idToken, deviceId: deviceId);

        await _authLocalDataSource.saveToken(
            token: remoteData.netData?.accessToken ?? '',
            refreshToken: remoteData.netData?.refreshToken ?? '');
      }
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> logOut(
      {required Map<String, dynamic> query}) {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithEmail(
      {required Map<String, dynamic> query}) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> reSendEmailResetPassword(
      {required Map<String, dynamic> query}) {
    // TODO: implement reSendEmailResetPassword
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> sendEmailResetPassword(
      {required Map<String, dynamic> query}) {
    // TODO: implement sendEmailResetPassword
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> signUpNewAccount(
      {required Map<String, dynamic> query}) {
    // TODO: implement signUpNewAccount
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateAccountPassword(
      {required Map<String, dynamic> query}) {
    // TODO: implement updateAccountPassword
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateNewPassword(
      {required Map<String, dynamic> query}) {
    // TODO: implement updateNewPassword
    throw UnimplementedError();
  }
}

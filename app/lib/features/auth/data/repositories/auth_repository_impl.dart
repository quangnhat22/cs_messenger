import 'package:app/features/auth/data/sources/firebase/auth_firebase_data_source.dart';
import 'package:app/features/auth/data/sources/local/auth_local_data_src.dart';
import 'package:app/features/auth/data/sources/local/device_info_local_data_src.dart';
import 'package:app/features/auth/data/sources/local/first_install_app_local_data_src.dart';
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
  late final FirstInstallAppLocalDataSource _firstInstallAppLocalDataSource;

  AuthRepositoryImpl(
    this._authFirebaseDataSource,
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._deviceInfoLocalDataSource,
    this._firstInstallAppLocalDataSource,
  );

  Future<void> _removeLocal() async {
    try {
      await _authLocalDataSource.clearToken();
      await _firstInstallAppLocalDataSource.deleteBox();
      await _deviceInfoLocalDataSource.deleteBox();
    } on LocalException catch (_) {
      rethrow;
    }
  }

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
      await _removeLocal();
      await _authFirebaseDataSource.logOut();
      return AppObjResultModel(netData: EmptyModel());
    } on LocalException catch (_) {
      rethrow;
    } on NetworkException catch (_) {
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
  Future<AppObjResultModel<EmptyModel>> signUpNewAccount(
      {required Map<String, dynamic> query}) async {
    try {
      await _authRemoteDataSource.registerNewAccount(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithEmail(
      {required Map<String, dynamic> query}) async {
    try {
      final deviceId = await _deviceInfoLocalDataSource.getDeviceId();

      query.putIfAbsent('device_id', () => deviceId);

      await _authRemoteDataSource.loginByEmailAndPassword(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithEmailUnVerify(
      {required Map<String, dynamic> query}) async {
    try {
      final deviceId = await _deviceInfoLocalDataSource.getDeviceId();

      query.putIfAbsent('device_id', () => deviceId);

      await _firstInstallAppLocalDataSource.setTempEmail(query['email']);
      await _firstInstallAppLocalDataSource
          .setExpireTime(DateTime.now().add(const Duration(hours: 1)));

      await _authRemoteDataSource.loginByEmailAndPassword(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on GrpcException catch (e) {
      if (e.data?["access_token"] != null) {
        await _authLocalDataSource.saveToken(
          token: e.data!["access_token"],
          refreshToken: '',
        );
      }
      rethrow;
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmailVerifyModel>> getEmailVerifyToken() async {
    try {
      final token = await _authLocalDataSource.getToken();
      final email = await _firstInstallAppLocalDataSource.getTempEmail();
      return AppObjResultModel(
        netData: EmailVerifyModel(
          token: token.netData?.raw2Model(),
          email: email,
        ),
      );
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @Deprecated('Need to implement in the future')
  @override
  Future<AppObjResultModel<EmptyModel>> verifyEmail() async {
    try {
      final token = await _authLocalDataSource.getToken();
      if (token.netData?.accessToken != null) {
        // await _authRemoteDataSource.verifyEmail(token.netData!.accessToken!);
        await _firstInstallAppLocalDataSource.removeTempEmail();
      }
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> forgotPassword(
      {required Map<String, dynamic> query}) async {
    try {
      await _authRemoteDataSource.forgotPassword(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

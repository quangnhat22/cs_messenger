import 'package:app/features/auth/data/sources/firebase/auth_firebase_data_source.dart';
import 'package:app/features/auth/data/sources/local/auth_local_data_src.dart';
import 'package:app/features/auth/data/sources/local/device_info_local_data_src.dart';
import 'package:app/features/auth/data/sources/local/first_install_app_local_data_src.dart';
import 'package:app/features/auth/data/sources/remote/auth_remote_data_src.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/notification/data/sources/local/notification_local_data_src.dart';
import 'package:app/features/user/data/resources/local/user_local_data_src.dart';
import 'package:app/service/onesignal/onesignal_service.dart';
import 'package:app/service/socket/socket_service.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  late final OneSignalService _oneSignalService;
  late final RealtimeService _realtimeService;
  late final AuthFirebaseDataSource _authFirebaseDataSource;
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final AuthLocalDataSource _authLocalDataSource;
  late final DeviceInfoLocalDataSource _deviceInfoLocalDataSource;
  late final FirstInstallAppLocalDataSource _firstInstallAppLocalDataSource;
  late final NotificationLocalDataSource _notificationLocalDataSource;
  late final UserLocalDataSource _userLocalDataSource;

  AuthRepositoryImpl(
    this._oneSignalService,
    this._realtimeService,
    this._authFirebaseDataSource,
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._deviceInfoLocalDataSource,
    this._firstInstallAppLocalDataSource,
    this._notificationLocalDataSource,
    this._userLocalDataSource,
  );

  Future<void> _removeLocal() async {
    try {
      await _authLocalDataSource.clearToken();
      await _firstInstallAppLocalDataSource.deleteBox();
      await _notificationLocalDataSource.deleteBox();
      await _userLocalDataSource.deleteBox();
      //
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
      await _deviceInfoLocalDataSource.deleteBox();
      await _authFirebaseDataSource.logOut();
      await _oneSignalService.logOut();
      //_realtimeService.disconnectSocket();
      return AppObjResultModel(netData: EmptyModel());
    } on LocalException catch (_) {
      rethrow;
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> logOut() async {
    try {
      await _authRemoteDataSource.logOut();
      await _removeLocal();
      await _authFirebaseDataSource.logOut();
      await _oneSignalService.logOut();
      //_realtimeService.disconnectSocket();
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on AppException catch (_) {
      await _removeLocal();
      rethrow;
    } catch (_) {
      await _removeLocal();
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
    } on GrpcException catch (_) {
      rethrow;
    } catch (e) {
      Logs.e(e);
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> signUpNewAccount(
      {required Map<String, dynamic> query}) async {
    try {
      await _authRemoteDataSource.registerNewAccount(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithEmail(
      {required Map<String, dynamic> query}) async {
    try {
      final deviceId = await _deviceInfoLocalDataSource.getDeviceId();

      query.putIfAbsent('device_id', () => deviceId);

      final tokenRaw =
          await _authRemoteDataSource.loginByEmailAndPassword(body: query);

      final accessToken = tokenRaw.netData?.accessToken;
      final refreshToken = tokenRaw.netData?.refreshToken;

      if (accessToken != null && refreshToken != null) {
        await _authLocalDataSource.saveToken(
          token: accessToken,
          refreshToken: refreshToken,
        );
      }
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on GrpcException catch (e) {
      if (e.data?["access_token"] != null) {
        await _firstInstallAppLocalDataSource.setTempEmail(query['email']);
        await _firstInstallAppLocalDataSource
            .setExpireTime(DateTime.now().add(const Duration(hours: 1)));
        await _authLocalDataSource.saveToken(token: e.data!["access_token"]);
      }
      rethrow;
    } on AppException catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> loginWithEmailUnVerify(
      {required Map<String, dynamic> query}) async {
    try {
      final deviceId = await _deviceInfoLocalDataSource.getDeviceId();

      query.putIfAbsent('device_id', () => deviceId);

      await _authRemoteDataSource.loginByEmailAndPassword(body: query);

      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on GrpcException catch (e) {
      if (e.data?["access_token"] != null) {
        await _firstInstallAppLocalDataSource.setTempEmail(query['email']);
        await _firstInstallAppLocalDataSource
            .setExpireTime(DateTime.now().add(const Duration(hours: 1)));
        await _authLocalDataSource.saveToken(token: e.data!["access_token"]);
      }
      rethrow;
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmailVerifyModel>> getEmailVerifyToken() async {
    try {
      final token = await _authLocalDataSource.getToken();
      final email = await _firstInstallAppLocalDataSource.getTempEmail();
      final expireTime = await _firstInstallAppLocalDataSource.getExpireTime();
      return AppObjResultModel(
        netData: EmailVerifyModel(
          token: token.netData?.raw2Model(),
          email: email,
          expireTime: expireTime,
        ),
      );
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<StatusVerifyEmailModel>> checkVerifyEmail() async {
    try {
      final remoteData = await _authRemoteDataSource.checkVerifyEmail();
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> forgotPassword(
      {required Map<String, dynamic> query}) async {
    try {
      await _authRemoteDataSource.forgotPassword(body: query);
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> requestResendEmailVerify() async {
    try {
      await _authRemoteDataSource.requestResendEmail();
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> changePassword(
      {required Map<String, dynamic> query}) async {
    try {
      await _authRemoteDataSource.changePassword(body: query);
      return AppObjResultModel<EmptyModel>(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }
}

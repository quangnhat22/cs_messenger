import 'package:app/features/auth/data/sources/number_install_app_data_src.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final NumberInstallAppDataSource _numberInstallAppLocal;

  AuthRepositoryImpl(this._numberInstallAppLocal);

  @override
  Future<AppObjResultModel<WelcomeModel>> checkIsFirstInstall() async {
    try {
      final isFirstInstallApp =
          await _numberInstallAppLocal.getIsFirstInstall();
      return Future.value(
        AppObjResultRaw(netData: WelcomeRaw(isFirstInstall: isFirstInstallApp))
            .raw2Model(),
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateValueFirstInstall() async {
    try {
      await _numberInstallAppLocal.updateIsFirstInstall();
      return Future.value(
        AppObjResultRaw(netData: EmptyRaw()).raw2Model(),
      );
    } catch (_) {
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
  Future<AppObjResultModel<EmptyModel>> loginWithGoogle() {
    // TODO: implement loginWithGoogle
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

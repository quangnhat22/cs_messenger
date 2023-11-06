import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<AppObjResultModel<TokenModel>> getTokenFromLocal();

  Future<AppObjResultModel<EmptyModel>> forceLogOut();

  Future<AppObjResultModel<EmptyModel>> loginWithGoogle();

  Future<AppObjResultModel<EmptyModel>> signUpNewAccount(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> loginWithEmail(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> sendEmailResetPassword(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> reSendEmailResetPassword(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> updateAccountPassword(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> updateNewPassword(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> logOut(
      {required Map<String, dynamic> query});
}

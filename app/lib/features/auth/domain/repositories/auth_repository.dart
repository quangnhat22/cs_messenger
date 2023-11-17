import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<AppObjResultModel<TokenModel>> getTokenFromLocal();

  Future<AppObjResultModel<EmptyModel>> forceLogOut();

  Future<AppObjResultModel<EmptyModel>> logOut();

  Future<AppObjResultModel<EmptyModel>> loginWithGoogle();

  Future<AppObjResultModel<EmptyModel>> signUpNewAccount(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> loginWithEmail(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> loginWithEmailUnVerify(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmailVerifyModel>> getEmailVerifyToken();

  Future<AppObjResultModel<EmptyModel>> requestResendEmailVerify();

  Future<AppObjResultModel<StatusVerifyEmailModel>> checkVerifyEmail();

  Future<AppObjResultModel<EmptyModel>> forgotPassword(
      {required Map<String, dynamic> query});
}

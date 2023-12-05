import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<AppObjResultModel<UserModel>> getUserSelf();

  Future<AppObjResultModel<UserModel>> getUserSelfFromLocal();

  Future<AppObjResultModel<UserModel>> getUserById(
      {required Map<String, dynamic> request});

  Future<AppObjResultModel<EmptyModel>> updateUserProfile(
      {required Map<String, dynamic> body});

  Stream<UserModel?> getUserLocalStream();
}

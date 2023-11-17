import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<AppObjResultModel<UserModel>> getUserSelf();

  Future<AppObjResultModel<EmptyModel>> updateUserProfile(
      {required Map<String, dynamic> body});
}

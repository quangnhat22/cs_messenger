import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<AppObjResultModel<UserModel>> getUserModel();
}

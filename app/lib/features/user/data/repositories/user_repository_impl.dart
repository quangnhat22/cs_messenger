import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  @override
  Future<AppObjResultModel<UserModel>> getUserModel() {
    // TODO: implement getUserModel
    throw UnimplementedError();
  }
}

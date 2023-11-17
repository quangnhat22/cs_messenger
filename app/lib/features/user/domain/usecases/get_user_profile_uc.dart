import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserProfile extends BaseUseCase<BaseParam, UserModel> {}

@Injectable(as: GetUserProfile)
class GetUserProfileImpl extends GetUserProfile {
  final UserRepository _repo;

  GetUserProfileImpl(this._repo);

  @override
  Future<AppObjResultModel<UserModel>> executeObj({BaseParam? request}) async =>
      await _repo.getUserModel();
}

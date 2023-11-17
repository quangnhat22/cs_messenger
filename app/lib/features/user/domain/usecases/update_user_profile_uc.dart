import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateUserProfileUseCase
    extends BaseUseCase<BaseParam, UserModel> {}

@Injectable(as: UpdateUserProfileUseCase)
class UpdateUserProfileUseCaseImpl extends UpdateUserProfileUseCase {
  final UserRepository _repo;

  UpdateUserProfileUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<UserModel>> executeObj({BaseParam? request}) async =>
      await _repo.getUserSelf();
}

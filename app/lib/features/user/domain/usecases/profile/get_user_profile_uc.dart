import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserProfileUseCase
    extends BaseUseCase<BaseParam, UserModel> {}

@Injectable(as: GetUserProfileUseCase)
class GetUserProfileUseCaseImpl extends GetUserProfileUseCase {
  final UserRepository _repo;

  GetUserProfileUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<UserModel>> executeObj({BaseParam? request}) async =>
      await _repo.getUserSelf();
}

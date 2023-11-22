import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateUserProfileUseCase
    extends BaseUseCase<UpdateUserSelfParam, EmptyModel> {}

@Injectable(as: UpdateUserProfileUseCase)
class UpdateUserProfileUseCaseImpl extends UpdateUserProfileUseCase {
  final UserRepository _repo;

  UpdateUserProfileUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {UpdateUserSelfParam? request}) async =>
      await _repo.updateUserProfile(body: request?.toJson() ?? {});
}

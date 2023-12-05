import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserProfileLocalUseCase
    extends BaseUseCase<BaseParam, UserModel> {}

@Injectable(as: GetUserProfileLocalUseCase)
class GetUserProfileLocalUseCaseImpl extends GetUserProfileLocalUseCase {
  final UserRepository _repo;

  GetUserProfileLocalUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<UserModel>> executeObj({BaseParam? request}) async =>
      await _repo.getUserSelfFromLocal();

  @override
  Stream<UserModel?> getStream() {
    return _repo.getUserLocalStream();
  }
}

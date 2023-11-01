import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateIsFirstInstalledUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: UpdateIsFirstInstalledUseCase)
class UpdateIsFirstInstalledUseCaseImpl extends UpdateIsFirstInstalledUseCase {
  final AuthRepository _repo;

  UpdateIsFirstInstalledUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.updateValueFirstInstall();
}

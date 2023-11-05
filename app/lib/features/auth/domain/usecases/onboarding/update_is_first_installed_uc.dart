import 'package:app/features/auth/domain/repositories/first_open_app_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateIsFirstInstalledUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: UpdateIsFirstInstalledUseCase)
class UpdateIsFirstInstalledUseCaseImpl extends UpdateIsFirstInstalledUseCase {
  final FirstOpenAppRepository _repo;

  UpdateIsFirstInstalledUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.updateValueFirstInstall();
}

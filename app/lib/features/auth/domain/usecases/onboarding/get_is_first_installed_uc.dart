import 'package:app/features/auth/domain/repositories/first_open_app_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetIsFirstInstalledUseCase
    extends BaseUseCase<BaseParam, WelcomeModel> {}

@Injectable(as: GetIsFirstInstalledUseCase)
class GetIsFirstInstalledUseCaseImpl extends GetIsFirstInstalledUseCase {
  final FirstOpenAppRepository _repo;

  GetIsFirstInstalledUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<WelcomeModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.checkIsFirstInstall();
}

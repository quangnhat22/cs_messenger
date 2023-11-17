import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class CheckVerifyEmailUseCase
    extends BaseUseCase<BaseParam, StatusVerifyEmailModel> {}

@Injectable(as: CheckVerifyEmailUseCase)
class VerifyEmailUseCaseImpl extends CheckVerifyEmailUseCase {
  final AuthRepository _repo;

  VerifyEmailUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<StatusVerifyEmailModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.checkVerifyEmail();
}

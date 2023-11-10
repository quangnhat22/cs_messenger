import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class VerifyEmailUseCase extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: VerifyEmailUseCase)
class VerifyEmailUseCaseImpl extends VerifyEmailUseCase {
  final AuthRepository _repo;

  VerifyEmailUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.verifyEmail();
}

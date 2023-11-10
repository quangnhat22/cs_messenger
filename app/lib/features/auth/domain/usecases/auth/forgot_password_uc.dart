import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class ForgotPasswordUseCase
    extends BaseUseCase<ForgotPasswordParam, EmptyModel> {}

@Injectable(as: ForgotPasswordUseCase)
class ForgotPasswordUseCaseImpl extends ForgotPasswordUseCase {
  final AuthRepository _repo;

  ForgotPasswordUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.forceLogOut();
}

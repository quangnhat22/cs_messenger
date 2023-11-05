import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class LoginWithGoogleUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: LoginWithGoogleUseCase)
class LoginWithGoogleUseCaseImpl extends LoginWithGoogleUseCase {
  final AuthRepository _repo;

  LoginWithGoogleUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.loginWithGoogle();
}

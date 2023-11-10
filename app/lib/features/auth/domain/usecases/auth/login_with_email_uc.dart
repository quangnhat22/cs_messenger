import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class LoginWithEmailUseCase
    extends BaseUseCase<LoginWithEmailParam, EmptyModel> {}

@Injectable(as: LoginWithEmailUseCase)
class LoginWithEmailUseCaseImpl extends LoginWithEmailUseCase {
  final AuthRepository _repo;

  LoginWithEmailUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {LoginWithEmailParam? request}) async =>
      await _repo.loginWithEmail(query: request?.toJson() ?? {});
}

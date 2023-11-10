import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class LoginWithEmailUnVerifyUseCase
    extends BaseUseCase<LoginWithEmailParam, EmptyModel> {}

@Injectable(as: LoginWithEmailUnVerifyUseCase)
class LoginWithEmailUnVerifyUseCaseImpl extends LoginWithEmailUnVerifyUseCase {
  final AuthRepository _repo;

  LoginWithEmailUnVerifyUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {LoginWithEmailParam? request}) async =>
      await _repo.loginWithEmailUnVerify(query: request?.toJson() ?? {});
}

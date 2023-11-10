import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class CreateNewAccountUseCase
    extends BaseUseCase<SignUpParam, EmptyModel> {}

@Injectable(as: CreateNewAccountUseCase)
class CreateNewAccountUseCaseImpl extends CreateNewAccountUseCase {
  final AuthRepository _repo;

  CreateNewAccountUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {SignUpParam? request}) async =>
      await _repo.signUpNewAccount(query: request?.toJson() ?? {});
}

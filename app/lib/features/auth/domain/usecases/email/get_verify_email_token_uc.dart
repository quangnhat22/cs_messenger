import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetVerifyEmailTokenUseCase
    extends BaseUseCase<BaseParam, EmailVerifyModel> {}

@Injectable(as: GetVerifyEmailTokenUseCase)
class GetVerifyEmailTokenUseCaseImpl extends GetVerifyEmailTokenUseCase {
  final AuthRepository _repo;

  GetVerifyEmailTokenUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmailVerifyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.getEmailVerifyToken();
}

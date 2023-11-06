import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class CheckAuthenticatedUseCase
    extends BaseUseCase<BaseParam, TokenModel> {}

@Injectable(as: CheckAuthenticatedUseCase)
class CheckAuthenticatedUseCaseImpl extends CheckAuthenticatedUseCase {
  final AuthRepository _repo;

  CheckAuthenticatedUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<TokenModel>> executeObj(
      {BaseParam? request}) async =>
      await _repo.getTokenFromLocal();
}

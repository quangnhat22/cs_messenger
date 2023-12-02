import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class ChangePasswordUseCase
    extends BaseUseCase<ChangePasswordParam, EmptyModel> {}

@Injectable(as: ChangePasswordUseCase)
class ChangePasswordUseCaseImpl extends ChangePasswordUseCase {
  final AuthRepository _repo;

  ChangePasswordUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ChangePasswordParam? request}) async =>
      await _repo.changePassword(query: request?.toJson() ?? {});
}

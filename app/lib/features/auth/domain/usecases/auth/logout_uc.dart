import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class LogOutUseCase extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: LogOutUseCase)
class LogOutUseCaseImpl extends LogOutUseCase {
  final AuthRepository _repo;

  LogOutUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.logOut();
}

import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class ForceLogOutUseCase extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: ForceLogOutUseCase)
class ForceLogOutUseCaseImpl extends ForceLogOutUseCase {
  final AuthRepository _repo;

  ForceLogOutUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.forceLogOut();
}

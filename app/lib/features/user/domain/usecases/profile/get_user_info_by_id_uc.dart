import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetUserInfoByIdUseCase
    extends BaseUseCase<ActionRequestParam, UserModel> {}

@Injectable(as: GetUserInfoByIdUseCase)
class GetUserInfoByIdUseCaseImpl extends GetUserInfoByIdUseCase {
  final UserRepository _repo;

  GetUserInfoByIdUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<UserModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.getUserById(request: request?.toJson() ?? {});
}

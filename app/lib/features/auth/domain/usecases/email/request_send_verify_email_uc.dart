import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class RequestSendVerifyEmailUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: RequestSendVerifyEmailUseCase)
class RequestSendVerifyEmailUseCaseImpl extends RequestSendVerifyEmailUseCase {
  final AuthRepository _repo;

  RequestSendVerifyEmailUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.requestResendEmailVerify();
}

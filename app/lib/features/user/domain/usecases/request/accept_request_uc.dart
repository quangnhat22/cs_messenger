import 'package:app/features/user/domain/repositories/request_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class AcceptRequestUseCase
    extends BaseUseCase<ActionRequestParam, EmptyModel> {}

@Injectable(as: AcceptRequestUseCase)
class AcceptRequestUseCaseImpl extends AcceptRequestUseCase {
  final RequestRepository _repo;

  AcceptRequestUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.acceptRequest(query: request?.toJson() ?? {});
}

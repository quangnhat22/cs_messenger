import 'package:app/features/user/domain/repositories/request_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteRequestUseCase
    extends BaseUseCase<ActionRequestParam, EmptyModel> {}

@Injectable(as: DeleteRequestUseCase)
class DeleteRequestUseCaseImpl extends DeleteRequestUseCase {
  final RequestRepository _repo;

  DeleteRequestUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.deleteRequest(query: request?.toJson() ?? {});
}

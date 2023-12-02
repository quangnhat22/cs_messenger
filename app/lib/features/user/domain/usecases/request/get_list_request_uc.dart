import 'package:app/features/user/domain/repositories/request_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListRequestUseCase
    extends BaseUseCase<GetListRequestParam, RequestModel> {}

@Injectable(as: GetListRequestUseCase)
class GetListRequestUseCaseImpl extends GetListRequestUseCase {
  final RequestRepository _repo;

  GetListRequestUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<RequestModel>> executeList(
          {GetListRequestParam? request}) async =>
      await _repo.getListRequest(query: request?.toJson() ?? {});
}

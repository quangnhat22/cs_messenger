import 'package:app/features/group/domain/features/get_list_group/get_list_group_param.dart';
import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListGroupUseCase
    extends BaseUseCase<GetListGroupParam, GroupModel> {}

@Injectable(as: GetListGroupUseCase)
class GetListCallHistoryUseCaseImpl extends GetListGroupUseCase {
  final GroupRepository _repo;

  GetListCallHistoryUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<GroupModel>> executeList(
          {GetListGroupParam? request}) async =>
      await _repo.getListGroup(query: request?.toJson() ?? {});
}

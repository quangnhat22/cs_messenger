import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListMemberGroupUseCase
    extends BaseUseCase<GetListMemberGroupParam, UserModel> {}

@Injectable(as: GetListMemberGroupUseCase)
class GetListMemberGroupUseCaseImpl extends GetListMemberGroupUseCase {
  final GroupRepository _repo;

  GetListMemberGroupUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<UserModel>> executeList(
          {GetListMemberGroupParam? request}) async =>
      await _repo.getListMemberGroup(query: request?.toJson() ?? {});
}

import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class LeaveGroupUseCase
    extends BaseUseCase<LeaveGroupParam, EmptyModel> {}

@Injectable(as: LeaveGroupUseCase)
class LeaveGroupUseCaseImpl extends LeaveGroupUseCase {
  final GroupRepository _repo;

  LeaveGroupUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj({LeaveGroupParam? request}) {
    return _repo.leaveGroup(request: request?.toJson() ?? {});
  }
}

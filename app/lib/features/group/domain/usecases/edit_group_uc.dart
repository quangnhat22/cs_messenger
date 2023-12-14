import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class EditGroupUseCase
    extends BaseUseCase<EditGroupParam, EmptyModel> {}

@Injectable(as: EditGroupUseCase)
class EditGroupUseCaseImpl extends EditGroupUseCase {
  final GroupRepository _repo;

  EditGroupUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {EditGroupParam? request}) async =>
      await _repo.createNewGroup(request: request?.toJson() ?? {});
}

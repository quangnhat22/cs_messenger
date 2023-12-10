import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class CreateNewGroupUseCase
    extends BaseUseCase<CreateNewGroupParam, EmptyModel> {}

@Injectable(as: CreateNewGroupUseCase)
class CreateNewGroupUseCaseImpl extends CreateNewGroupUseCase {
  final GroupRepository _repo;

  CreateNewGroupUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {CreateNewGroupParam? request}) async =>
      await _repo.createNewGroup(request: request?.toJson() ?? {});
}

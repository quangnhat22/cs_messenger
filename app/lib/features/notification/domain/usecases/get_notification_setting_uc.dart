import 'package:app/features/group/domain/repositories/group_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetNotificationSettingUseCase
    extends BaseUseCase<CreateNewGroupParam, EmptyModel> {}

@Injectable(as: GetNotificationSettingUseCase)
class GetNotificationSettingUseCaseImpl extends GetNotificationSettingUseCase {
  final GroupRepository _repo;

  GetNotificationSettingUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {CreateNewGroupParam? request}) async =>
      await _repo.createNewGroup(request: request?.toJson() ?? {});
}

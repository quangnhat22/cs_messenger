import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteNotificationUseCase
    extends BaseUseCase<CreateNewGroupParam, EmptyModel> {}

@Injectable(as: DeleteNotificationUseCase)
class DeleteNotificationUseCaseImpl extends DeleteNotificationUseCase {
  final NotificationRepository _repo;

  DeleteNotificationUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
      {CreateNewGroupParam? request}) {
    // TODO: implement executeObj
    return super.executeObj();
  }
}

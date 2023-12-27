import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteAllNotificationUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: DeleteAllNotificationUseCase)
class DeleteAllNotificationUseCaseImpl extends DeleteAllNotificationUseCase {
  final NotificationRepository _repo;

  DeleteAllNotificationUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.deleteAllNotification();
}

import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteNotificationByIdUseCase
    extends BaseUseCase<DeleteNotificationByIdParam, EmptyModel> {}

@Injectable(as: DeleteNotificationByIdUseCase)
class DeleteNotificationByIdUseCaseImpl extends DeleteNotificationByIdUseCase {
  final NotificationRepository _repo;

  DeleteNotificationByIdUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {DeleteNotificationByIdParam? request}) async =>
      await _repo.deleteNotificationById(query: request?.toJson() ?? {});
}

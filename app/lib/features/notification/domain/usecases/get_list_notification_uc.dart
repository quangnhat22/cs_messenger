import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListNotificationUseCase
    extends BaseUseCase<GetListNotificationParam, NotificationModel> {}

@Injectable(as: GetListNotificationUseCase)
class GetListNotificationUseCaseImpl extends GetListNotificationUseCase {
  final NotificationRepository _repo;

  GetListNotificationUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<NotificationModel>> executeList(
      {GetListNotificationParam? request}) async {
    return await _repo.getListNotification(query: request?.toJson() ?? {});
  }
}

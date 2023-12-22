import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListNotificationUseCase
    extends BaseUseCase<CreateNewGroupParam, EmptyModel> {}

@Injectable(as: GetListNotificationUseCase)
class GetListNotificationUseCaseImpl extends GetListNotificationUseCase {
  final NotificationRepository _repo;

  GetListNotificationUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<EmptyModel>> executeList(
      {CreateNewGroupParam? request}) {
    // TODO: implement executeList
    return super.executeList();
  }
}

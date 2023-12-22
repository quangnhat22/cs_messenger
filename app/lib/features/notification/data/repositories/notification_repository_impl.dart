import 'package:app/features/notification/data/sources/remote/notification_remote_data_src.dart';
import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:domain/src/models/base_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  late final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<AppListResultModel<EmptyModel>> deleteNotification(
      {required Map<String, dynamic> query}) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<AppListResultModel<EmptyModel>> getListNotification(
      {required Map<String, dynamic> query}) {
    // TODO: implement getListNotification
    throw UnimplementedError();
  }
}

import 'package:app/features/notification/data/sources/local/notification_local_data_src.dart';
import 'package:app/features/notification/domain/repositories/setting_notification_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingNotificationRepository)
class SettingNotificationRepositoryImpl extends SettingNotificationRepository {
  late final NotificationLocalDataSource _localDataSource;

  SettingNotificationRepositoryImpl(this._localDataSource);

  @override
  Future<AppListResultModel<EmptyModel>> getNotificationReceiveStatus(
      {required Map<String, dynamic> query}) {
    // TODO: implement getNotificationReceiveStatus
    throw UnimplementedError();
  }

  @override
  Future<AppListResultModel<EmptyModel>> updateNotificationReceiveStatus(
      {required Map<String, dynamic> query}) {
    // TODO: implement updateNotificationReceiveStatus
    throw UnimplementedError();
  }
}

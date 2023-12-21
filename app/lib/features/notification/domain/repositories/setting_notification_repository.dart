import 'package:domain/domain.dart';

abstract class SettingNotificationRepository {
  Future<AppListResultModel<EmptyModel>> updateNotificationReceiveStatus(
      {required Map<String, dynamic> query});

  Future<AppListResultModel<EmptyModel>> getNotificationReceiveStatus(
      {required Map<String, dynamic> query});
}

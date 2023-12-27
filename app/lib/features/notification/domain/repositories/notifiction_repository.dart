import 'package:domain/domain.dart';

abstract class NotificationRepository {
  Future<AppListResultModel<NotificationModel>> getListNotification(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> deleteNotificationById(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> deleteAllNotification();
}

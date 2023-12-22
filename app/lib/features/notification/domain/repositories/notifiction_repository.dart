import 'package:domain/domain.dart';

abstract class NotificationRepository {
  Future<AppListResultModel<EmptyModel>> getListNotification(
      {required Map<String, dynamic> query});

  Future<AppListResultModel<EmptyModel>> deleteNotification(
      {required Map<String, dynamic> query});
}

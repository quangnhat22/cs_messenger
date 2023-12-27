import 'package:app/features/notification/data/sources/remote/notification_remote_data_src.dart';
import 'package:app/features/notification/domain/repositories/notifiction_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  late final NotificationRemoteDataSource _remote;

  NotificationRepositoryImpl(this._remote);

  @override
  Future<AppListResultModel<NotificationModel>> getListNotification(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<NotificationRaw> remoteData =
          await _remote.getListNotification(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> deleteAllNotification() async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.deleteAllNotification();
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> deleteNotificationById(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.deleteNotificationById(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

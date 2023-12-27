import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRemoteDataSource {
  Future<AppListResultRaw<NotificationRaw>> getListNotification(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> deleteNotificationById(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> deleteAllNotification();
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  late final NetworkService _service;

  NotificationRemoteDataSourceImpl(this._service);

  @override
  Future<AppListResultRaw<NotificationRaw>> getListNotification(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.notifications,
          method: HttpMethod.get,
          query: {...query},
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => NotificationRaw.fromJson(item))
          .toList());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> deleteAllNotification() {
    // TODO: implement deleteAllNotification
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> deleteNotificationById(
      {required Map<String, dynamic> query}) {
    // TODO: implement deleteNotificationById
    throw UnimplementedError();
  }
}

import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRemoteDataSource {
  Future<AppObjResultRaw<EmptyRaw>> getListNotification(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<TokenRaw>> deleteNotification(
      {String? idToken, String? deviceId});
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  late final NetworkService _service;

  NotificationRemoteDataSourceImpl(this._service);

  @override
  Future<AppObjResultRaw<TokenRaw>> deleteNotification(
      {String? idToken, String? deviceId}) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> getListNotification(
      {required Map<String, dynamic> body}) {
    // TODO: implement getListNotification
    throw UnimplementedError();
  }
}

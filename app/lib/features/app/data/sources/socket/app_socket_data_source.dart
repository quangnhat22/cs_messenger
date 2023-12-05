import 'package:domain/domain.dart';

abstract class AppSocketDataSource {
  Future<AppObjResultModel<EmptyModel>> fetchListCallHistory(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> fetchListFriend(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> deleteFriend(
      {required Map<String, dynamic> query});
}

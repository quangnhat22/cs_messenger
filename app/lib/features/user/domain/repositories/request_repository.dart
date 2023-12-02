import 'package:domain/domain.dart';

abstract class RequestRepository {
  Future<AppListResultModel<RequestModel>> getListRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> sentRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> acceptRequest(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> deleteRequest(
      {required Map<String, dynamic> query});
}

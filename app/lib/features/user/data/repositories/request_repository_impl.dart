import 'package:app/features/user/data/resources/remote/request_remote_data_src.dart';
import 'package:app/features/user/domain/repositories/request_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RequestRepository)
class RequestRepositoryImpl extends RequestRepository {
  late final RequestRemoteDataSource _remoteDataSource;

  RequestRepositoryImpl(this._remoteDataSource);

  @override
  Future<AppObjResultModel<EmptyModel>> acceptRequest(
      {required Map<String, dynamic> query}) async {
    try {
      await _remoteDataSource.acceptRequest(query: query);
      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> deleteRequest(
      {required Map<String, dynamic> query}) async {
    try {
      await _remoteDataSource.deleteRequest(query: query);
      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<RequestModel>> getListRequest(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<RequestRaw> remoteData =
          await _remoteDataSource.getListRequest(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> sentRequest(
      {required Map<String, dynamic> query}) async {
    try {
      await _remoteDataSource.sendRequest(query: query);
      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }
}

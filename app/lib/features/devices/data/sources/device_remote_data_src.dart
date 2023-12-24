import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceRemoteDataSource {
  Future<AppObjResultRaw<DeviceIdRaw>> registerNewDevice(
      {String? model, String? os, String? appVersion});

  Future<AppListResultRaw<DeviceRaw>> fetchListDevices(
      {required Map<String, dynamic> query});

  Future<AppObjResultRaw<EmptyRaw>> deleteDevice(
      {required Map<String, dynamic> query});
}

@Injectable(as: DeviceRemoteDataSource)
class DeviceRemoteDataSourceImpl extends DeviceRemoteDataSource {
  late final NetworkService _networkService;

  DeviceRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppObjResultRaw<DeviceIdRaw>> registerNewDevice(
      {String? model, String? os, String? appVersion}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.deviceRegister,
          method: HttpMethod.post,
          body: {
            "model": model,
            "os": os?.toLowerCase(),
            "app_version": appVersion
          },
        ),
      );
      return response.toRaw((data) => DeviceIdRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultRaw<DeviceRaw>> fetchListDevices(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.device,
          method: HttpMethod.get,
          query: {...query},
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => DeviceRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultRaw<EmptyRaw>> deleteDevice(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.deviceById(query['deviceId']),
          method: HttpMethod.delete,
        ),
      );
      return response.toRaw((data) => EmptyRaw());
    } on NetworkException catch (_) {
      rethrow;
    } on GrpcException catch (_) {
      rethrow;
    }
  }
}

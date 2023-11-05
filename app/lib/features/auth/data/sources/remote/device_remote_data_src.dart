import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceRemoteDataSource {
  Future<AppObjResultRaw<DeviceIdRaw>> registerNewDevice(
      {String? model, String? os, String? appVersion});
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
}

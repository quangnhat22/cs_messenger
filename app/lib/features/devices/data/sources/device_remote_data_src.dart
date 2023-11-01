import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceRemoteDataSource {
  Future<AppObjResultRaw<DeviceIdRaw>> registerNewDevice(
      {required Map<String, dynamic> body});
}

@Injectable(as: DeviceRemoteDataSource)
class DeviceRemoteDataSourceImpl extends DeviceRemoteDataSource {
  late final NetworkService _service;

  DeviceRemoteDataSourceImpl(this._service);

  @override
  Future<AppObjResultRaw<DeviceIdRaw>> registerNewDevice(
      {required Map<String, dynamic> body}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.deviceRegister,
          method: HttpMethod.post,
          body: body,
        ),
      );
      return response.toRaw((data) => DeviceIdRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

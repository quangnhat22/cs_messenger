import 'package:domain/domain.dart';

abstract class DeviceRepository {
  Future<AppObjResultModel<EmptyModel>> registerNewDevices();

  Future<AppObjResultModel<DeviceIdModel>> getIdRemoteDevice();
}

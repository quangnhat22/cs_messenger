import 'package:domain/domain.dart';

abstract class ListDeviceRepository {
  Future<AppListResultModel<DeviceModel>> getListDevices(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> deleteDevice(
      {required Map<String, dynamic> query});
}

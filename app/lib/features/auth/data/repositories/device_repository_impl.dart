import 'package:app/features/auth/data/sources/local/device_info_local_data_src.dart';
import 'package:app/features/auth/data/sources/remote/device_remote_data_src.dart';
import 'package:app/features/auth/domain/repositories/device_repository.dart';
import 'package:configs/configs.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DeviceRepository)
class DeviceRepositoryImpl implements DeviceRepository {
  late final DeviceInfoLocalDataSource _local;
  late final DeviceRemoteDataSource _remote;

  DeviceRepositoryImpl(this._local, this._remote);

  @override
  Future<AppObjResultModel<EmptyModel>> registerNewDevices() async {
    try {
      final deviceInfo = await DeviceInfo.getDeviceInfo();

      final remoteData = await _remote.registerNewDevice(
        model: deviceInfo['model'],
        os: deviceInfo['OS'],
        appVersion: deviceInfo['appVersion'],
      );

      await _local.setDeviceId(remoteData.netData?.id);

      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<DeviceIdModel>> getIdRemoteDevice() async {
    try {
      final idRemoteDevice = await _local.getDeviceId();

      return AppObjResultModel(
          netData: DeviceIdModel(id: idRemoteDevice ?? ''));
    } on LocalException catch (_) {
      rethrow;
    }
  }
}

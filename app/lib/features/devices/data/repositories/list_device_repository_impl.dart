import 'package:app/features/devices/data/sources/device_remote_data_src.dart';
import 'package:app/features/devices/domain/repositories/list_device_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ListDeviceRepository)
class ListDeviceRepositoryImpl extends ListDeviceRepository {
  late final DeviceRemoteDataSource _remote;

  ListDeviceRepositoryImpl(this._remote);

  @override
  Future<AppListResultModel<DeviceModel>> getListDevices(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<DeviceRaw> remoteData =
          await _remote.fetchListDevices(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> deleteDevice(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<EmptyRaw> remoteData =
          await _remote.deleteDevice(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

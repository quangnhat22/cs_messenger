import 'package:app/features/auth/domain/repositories/device_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetIdRemoteDeviceUseCase
    extends BaseUseCase<BaseParam, DeviceIdModel> {}

@Injectable(as: GetIdRemoteDeviceUseCase)
class GetIdRemoteDeviceUseCaseImpl extends GetIdRemoteDeviceUseCase {
  final DeviceRepository _repo;

  GetIdRemoteDeviceUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<DeviceIdModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.getIdRemoteDevice();
}

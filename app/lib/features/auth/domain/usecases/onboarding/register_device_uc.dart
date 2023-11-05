import 'package:app/features/auth/domain/repositories/device_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class RegisterDeviceUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: RegisterDeviceUseCase)
class RegisterDeviceUseCaseImpl extends RegisterDeviceUseCase {
  final DeviceRepository _repo;

  RegisterDeviceUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.registerNewDevices();
}

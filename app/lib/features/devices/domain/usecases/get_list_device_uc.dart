import 'package:app/features/devices/domain/repositories/list_device_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListDeviceUseCase
    extends BaseUseCase<GetListDeviceParam, DeviceModel> {}

@Injectable(as: GetListDeviceUseCase)
class GetListDeviceUseCaseImpl extends GetListDeviceUseCase {
  final ListDeviceRepository _repo;

  GetListDeviceUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<DeviceModel>> executeList(
          {GetListDeviceParam? request}) async =>
      await _repo.getListDevices(query: request?.toJson() ?? {});
}

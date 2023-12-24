import 'package:app/features/devices/domain/repositories/list_device_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteDeviceUseCase
    extends BaseUseCase<DeleteDeviceParam, EmptyModel> {}

@Injectable(as: DeleteDeviceUseCase)
class DeleteDeviceUseCaseImpl extends DeleteDeviceUseCase {
  final ListDeviceRepository _repo;

  DeleteDeviceUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
      {DeleteDeviceParam? request}) {
    return _repo.deleteDevice(query: request?.toJson() ?? {});
  }
}

import 'package:app/features/devices/domain/repositories/list_device_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListDeviceUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: GetListDeviceUseCase)
class GetListDeviceUseCaseImpl extends GetListDeviceUseCase {
  final ListDeviceRepository _repo;

  GetListDeviceUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<EmptyModel>> executeList(
          {BaseParam? request}) async =>
      await _repo.getListDevices();
}

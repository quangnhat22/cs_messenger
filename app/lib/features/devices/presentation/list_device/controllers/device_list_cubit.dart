import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/devices/domain/usecases/get_list_device_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeviceListCubit extends AppListViewCubit<DeviceModel> {
  late final GetListDeviceUseCase _getListDeviceUseCase;

  DeviceListCubit(this._getListDeviceUseCase);

  @override
  Future<AppListResultModel<DeviceModel>> onCall(AppParam appParam) async {
    return _getListDeviceUseCase.executeList(
      request: GetListDeviceParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

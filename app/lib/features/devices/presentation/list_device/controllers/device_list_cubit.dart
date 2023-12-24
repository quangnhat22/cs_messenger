import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/devices/domain/usecases/delete_device_uc.dart';
import 'package:app/features/devices/domain/usecases/get_list_device_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class DeviceListCubit extends AppListViewCubit<DeviceModel> {
  late final GetListDeviceUseCase _getListDeviceUseCase;
  late final DeleteDeviceUseCase _deleteDeviceUseCase;

  DeviceListCubit(
    this._getListDeviceUseCase,
    this._deleteDeviceUseCase,
  );

  @override
  Future<AppListResultModel<DeviceModel>> onCall(AppParam appParam) async {
    return _getListDeviceUseCase.executeList(
      request: GetListDeviceParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }

  Future<void> deleteDevice(String deviceId) async {
    try {
      await _deleteDeviceUseCase.executeObj(
          request: DeleteDeviceParam(deviceId: deviceId));
      AppSnackBarWidget()
          .setLabelText(R.strings.deleteDeviceSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
      await onRefreshCall();
    } on AppException catch (e) {
      AppSnackBarWidget()
          .setLabelText(R.strings.deleteDeviceFail)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.error)
          .showSnackBar();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}

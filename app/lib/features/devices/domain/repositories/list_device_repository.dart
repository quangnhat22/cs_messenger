import 'package:domain/domain.dart';

abstract class ListDeviceRepository {
  Future<AppListResultModel<EmptyModel>> getListDevices();
}

import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceInfoLocalDataSource extends BaseObjectDao {
  Future<void> setDeviceId(String? deviceId);
  Future<String?> getDevideId();
}

@LazySingleton(as: DeviceInfoLocalDataSource)
class DeviceInfoLocalDataSourceImpl extends DeviceInfoLocalDataSource {
  static Box? _box;
  final String _boxName = "device_info_box";

  final String _deviceInfoKey = "device_info_key";

  @override
  String get boxName => _boxName;

  @override
  Future<Box> openBox() async {
    _box ??= await Hive.openBox(_boxName);
    return _box!;
  }

  @override
  Future<void> deleteBox() async {
    await openBox().then((box) => box.clear());
  }

  @override
  Future<String?> getDevideId() async {
    return await openBox().then((box) {
      return box.get(_deviceInfoKey, defaultValue: null);
    });
  }

  @override
  Future<void> setDeviceId(String? deviceId) async {
    await openBox().then((box) {
      box.put(_deviceInfoKey, deviceId);
    });
  }
}

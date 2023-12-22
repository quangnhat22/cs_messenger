import 'package:app/configs/exts/app_exts.dart';
import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationLocalDataSource extends BaseObjectDao {
  Future<void> setNotificationStatus(bool value);

  Future<bool?> getNotificationStatus();
}

@LazySingleton(as: NotificationLocalDataSource)
class NotificationLocalDataSourceImpl extends NotificationLocalDataSource {
  static Box? _box;
  final String _boxName = AppLocalBoxKeys.notificationSettingBox;

  final String _notificationKey = "notification_key";

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
  Future<bool?> getNotificationStatus() async {
    return await openBox().then((box) {
      return box.get(_notificationKey, defaultValue: null);
    });
  }

  @override
  Future<void> setNotificationStatus(bool value) async {
    await openBox().then((box) {
      box.put(_notificationKey, value);
    });
  }
}

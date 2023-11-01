import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DeviceLocalDataSource extends BaseObjectDao {
  static Box? _box;
  final String _boxName = "auth_box";

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
}

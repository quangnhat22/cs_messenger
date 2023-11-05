import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class NumberInstallAppLocalDataSource extends BaseObjectDao {
  Future<bool> getIsFirstInstall();

  Future<void> updateIsFirstInstall({bool? value = false});
}

@Singleton(as: NumberInstallAppLocalDataSource)
class NumberInstallAppDataSourceImpl extends NumberInstallAppLocalDataSource {
  static Box? _box;
  final String _boxName = "number_install_box";

  final String _numberInstallKey = "number_install_key";

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
  Future<bool> getIsFirstInstall() async {
    return await openBox().then((box) {
      return box.get(_numberInstallKey, defaultValue: true);
    });
  }

  @override
  Future<void> updateIsFirstInstall({bool? value = false}) async {
    await openBox().then((box) {
      box.put(_numberInstallKey, value);
    });
  }
}

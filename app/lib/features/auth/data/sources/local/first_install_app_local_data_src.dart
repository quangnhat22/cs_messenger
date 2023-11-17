import 'package:app/configs/exts/app_exts.dart';
import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

//TODO: change name
abstract class FirstInstallAppLocalDataSource extends BaseObjectDao {
  Future<bool> getIsFirstInstall();

  Future<void> updateIsFirstInstall({bool? value = false});

  Future<String?> getTempEmail();

  Future<void> setTempEmail(String? email);

  Future<void> removeTempEmail();

  Future<DateTime?> getExpireTime();

  Future<void> setExpireTime(DateTime? expireTime);

  Future<void> removeExpireTime();
}

@Singleton(as: FirstInstallAppLocalDataSource)
class FirstInstallAppLocalDataSourceImpl
    extends FirstInstallAppLocalDataSource {
  static Box? _box;
  final String _boxName = AppLocalBoxKeys.firstInstallAppBox;

  final String _numberInstallKey = "is_first_install";
  final String _tempEmailKey = "temp_email";
  final String _expireTime = 'expire_time';

  @override
  String get boxName => _boxName;

  @override
  Future<Box> openBox() async {
    _box ??= await Hive.openBox(_boxName);
    return _box!;
  }

  @override
  Future<void> deleteBox() async {
    // await openBox().then((box) => box.clear());
    await removeExpireTime();
    await removeTempEmail();
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

  @override
  Future<String?> getTempEmail() async {
    return await openBox().then((box) {
      return box.get(_tempEmailKey, defaultValue: null);
    });
  }

  @override
  Future<void> setTempEmail(String? email) async {
    await openBox().then((box) {
      box.put(_tempEmailKey, email);
    });
  }

  @override
  Future<void> removeTempEmail() async {
    await openBox().then((box) {
      box.delete(_tempEmailKey);
    });
  }

  @override
  Future<DateTime?> getExpireTime() async {
    return await openBox().then((box) {
      return box.get(_expireTime, defaultValue: null);
    });
  }

  @override
  Future<void> setExpireTime(DateTime? expireTime) async {
    await openBox().then((box) {
      box.put(_expireTime, expireTime);
    });
  }

  @override
  Future<void> removeExpireTime() async {
    await openBox().then((box) {
      box.delete(_expireTime);
    });
  }
}

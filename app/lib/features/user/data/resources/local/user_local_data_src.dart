import 'package:app/configs/exts/app_exts.dart';
import 'package:data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class UserLocalDataSource extends BaseObjectDao {
  Future<UserRaw?> getUserInfo();

  Future<void> updateUserInfo(UserRaw user);
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl extends UserLocalDataSource {
  static Box? _box;
  final String _boxName = AppLocalBoxKeys.userBox;

  final String _userKey = "user_key";

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
  Future<UserRaw?> getUserInfo() async {
    return await openBox().then((box) {
      return box.get(_userKey, defaultValue: null);
    });
  }

  @override
  Future<void> updateUserInfo(UserRaw user) async {
    await openBox().then((box) {
      box.put(_userKey, user);
    });
  }
}

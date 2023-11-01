import 'package:hive/hive.dart';

abstract class BaseObjectDao {
  String get boxName;

  Future<Box> openBox();

  Future<void> deleteBox();
}

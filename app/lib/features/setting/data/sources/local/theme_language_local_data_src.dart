import 'package:app/configs/exts/app_exts.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ThemeLanguageLocalDataSrc {
  static Box? _box;
  final String _settingBox = AppLocalBoxKeys.themeLanguageBox;
  final String _themeKeyName = "theme_key";
  final String _langKeyName = "lang_key";

  Future<Box> _openBox() async {
    _box ??= await Hive.openBox(_settingBox);
    return _box!;
  }

  Future<void> setTheme(String value) async {
    await _openBox().then((box) async {
      await box.put(_themeKeyName, value);
    });
  }

  Future<String> getTheme() async {
    return await _openBox().then((box) {
      return box.get(_themeKeyName, defaultValue: "system");
    });
  }

  Stream<String?> getThemeStream() async* {
    final box = await _openBox();
    yield* box.watch(key: _themeKeyName).map((event) {
      return event.value;
    });
  }

  Future<void> setLanguage(String value) async {
    await _openBox().then((box) async {
      await box.put(_langKeyName, value);
    });
  }

  Future<String> getLanguage() async {
    return await _openBox().then((box) {
      return box.get(_langKeyName, defaultValue: "system");
    });
  }

  Stream<String?> getLanguageStream() async* {
    final box = await _openBox();
    yield* box.watch(key: _langKeyName).map((event) {
      return event.value;
    });
  }

  Future<void> deleteBoxSetting() async {
    await Hive.box(_settingBox).clear();
  }
}

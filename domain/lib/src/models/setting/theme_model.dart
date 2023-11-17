part of '../base_model.dart';

enum ThemeType {
  system('system'),
  light('light'),
  dark('dark');

  const ThemeType(this.value);

  final String value;

  static ThemeType convertStringToThemeType(String? type) {
    if (ThemeType.light.value == type) {
      return ThemeType.light;
    } else if (ThemeType.dark.value == type) {
      return ThemeType.dark;
    } else {
      return ThemeType.system;
    }
  }
}

class ThemeModel extends BaseModel {
  final ThemeType theme;

  ThemeModel({required this.theme});
}

part of '../base_model.dart';

enum LanguageType {
  vi('vi'),
  en('en'),
  system('system');

  const LanguageType(this.value);

  final String value;

  static LanguageType convertStringToThemeType(String? type) {
    if (LanguageType.vi.value == type) {
      return LanguageType.vi;
    } else if (LanguageType.en.value == type) {
      return LanguageType.en;
    } else {
      return LanguageType.system;
    }
  }
}

class LanguageModel extends BaseModel {
  final LanguageType language;

  LanguageModel({required this.language});
}

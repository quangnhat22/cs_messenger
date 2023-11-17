part of '../base_param.dart';

@freezed
class ThemeAndLanguageParam extends BaseParam with _$ThemeAndLanguageParam {
  const factory ThemeAndLanguageParam({required String value}) =
      _ThemeAndLanguageParam;

  factory ThemeAndLanguageParam.fromJson(Map<String, Object?> json) =>
      _$ThemeAndLanguageParamFromJson(json);
}

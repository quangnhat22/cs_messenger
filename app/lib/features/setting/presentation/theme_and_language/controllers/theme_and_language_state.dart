part of 'theme_and_language_cubit.dart';

@freezed
class ThemeAndLanguageState with _$ThemeAndLanguageState {
  const factory ThemeAndLanguageState.initial({
    @Default('system') String theme,
    @Default('en') String language,
  }) = _Initial;
}

part of 'app_theme_language_cubit.dart';

@freezed
class AppThemeLanguageState with _$AppThemeLanguageState {
  const factory AppThemeLanguageState.initial({
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(Locale('en', 'US')) Locale language,
  }) = _Initial;
}

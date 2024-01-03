import 'package:app/features/setting/domain/usecases/theme_language/get_language_uc.dart';
import 'package:app/features/setting/domain/usecases/theme_language/get_theme_uc.dart';
import 'package:app/features/setting/domain/usecases/theme_language/set_language_uc.dart';
import 'package:app/features/setting/domain/usecases/theme_language/set_theme_uc.dart';
import 'package:app/service/onesignal/onesignal_service.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'theme_and_language_cubit.freezed.dart';
part 'theme_and_language_state.dart';

@Injectable()
class ThemeAndLanguageCubit extends Cubit<ThemeAndLanguageState> {
  late final GetLanguageUseCase _getLanguageUseCase;
  late final GetThemeUseCase _getThemeUseCase;
  late final SetLanguageUseCase _setLanguageUseCase;
  late final SetThemeUseCase _setThemeUseCase;
  late final OneSignalService _oneSignalService;

  ThemeAndLanguageCubit(
    this._getThemeUseCase,
    this._getLanguageUseCase,
    this._setLanguageUseCase,
    this._setThemeUseCase,
    this._oneSignalService,
  ) : super(const ThemeAndLanguageState.initial());

  Future<void> initPage() async {
    try {
      final themeValue = await _getThemeUseCase.executeObj();
      final languageValue = await _getLanguageUseCase.executeObj();
      emit(
        state.copyWith(
          theme: themeValue.netData?.theme.value ?? ThemeType.system.value,
          language: languageValue.netData?.language.value ??
              LanguageType.system.value,
        ),
      );
    } on AppException catch (e) {
      Logs.e(e.toString());
    }
  }

  Future<void> changeTheme(String value) async {
    try {
      await _setThemeUseCase.executeObj(
          request: ThemeAndLanguageParam(value: value));
      emit(
        state.copyWith(theme: value),
      );
    } on AppException catch (e) {
      Logs.e(e.toString());
    }
  }

  Future<void> changeLanguage(String value) async {
    try {
      await _setLanguageUseCase.executeObj(
          request: ThemeAndLanguageParam(value: value));
      emit(
        state.copyWith(language: value),
      );
      await _oneSignalService.setLanguage(locale: value);
    } on AppException catch (e) {
      Logs.e(e.toString());
    } catch (e) {
      Logs.e(e);
    }
  }
}

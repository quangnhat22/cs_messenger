import 'dart:async';

import 'package:app/features/setting/domain/usecases/theme_language/get_language_uc.dart';
import 'package:app/features/setting/domain/usecases/theme_language/get_theme_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_theme_language_cubit.freezed.dart';
part 'app_theme_language_state.dart';

@Injectable()
class AppThemeLanguageCubit extends Cubit<AppThemeLanguageState> {
  late final GetLanguageUseCase _getLanguageUseCase;
  late final GetThemeUseCase _getThemeUseCase;

  AppThemeLanguageCubit(
    this._getLanguageUseCase,
    this._getThemeUseCase,
  ) : super(const AppThemeLanguageState.initial()) {
    // listen theme change from local storage
    _themeSub = _getThemeUseCase.getStream().listen((themeModel) {
      final theme = _convertToThemeMode(themeModel);
      emit(state.copyWith(theme: theme));
    });
    //listen lang change from local storage
    _langSub = _getLanguageUseCase.getStream().listen((value) {
      final locale = _convertToLocale(value);
      emit(state.copyWith(language: locale));
    });
  }

  late final StreamSubscription<ThemeModel> _themeSub;
  late final StreamSubscription<LanguageModel> _langSub;

  @override
  Future<void> close() async {
    await _themeSub.cancel();
    await _langSub.cancel();
    return super.close();
  }

  void initPage() async {
    final themeModel = await _getThemeUseCase.executeObj();
    final languageModel = await _getLanguageUseCase.executeObj();

    final theme = _convertToThemeMode(themeModel.netData);
    final locale = _convertToLocale(languageModel.netData);
    emit(state.copyWith(theme: theme, language: locale));
  }

  ThemeMode _convertToThemeMode(ThemeModel? theme) {
    switch (theme?.theme) {
      case ThemeType.dark:
        return ThemeMode.dark;
      case ThemeType.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Locale _convertToLocale(LanguageModel? language) {
    switch (language?.language) {
      case LanguageType.vi:
        return const Locale("vi", "VN");
      default:
        return const Locale("en", "US");
    }
  }
}

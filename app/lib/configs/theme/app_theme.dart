import 'dart:ui';

import 'package:flutter/material.dart';

part 'app_button_style.dart';
part 'app_colors.dart';
part 'app_text_style.dart';
part 'exts/app_color_palette_ext.dart';
part 'exts/app_size_ext.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      textTheme: _AppTextStyle.textTheme(),
      filledButtonTheme:
          FilledButtonThemeData(style: AppButtonStyle.filledButtonStyle),
      // textButtonTheme:
      //     TextButtonThemeData(style: AppButtonStyle.textButtonStyle),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: AppButtonStyle.outlinedButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(3)),
        ),
      ),
      // listTileTheme: ListTileThemeData(
      //   tileColor: Theme.of(context).colorScheme.onBackground,
      // ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: _AppTextStyle.textTheme(),
      filledButtonTheme:
          FilledButtonThemeData(style: AppButtonStyle.filledButtonStyle),
      // textButtonTheme:
      //     TextButtonThemeData(style: AppButtonStyle.textButtonStyle),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: AppButtonStyle.outlinedButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(3)),
        ),
      ),
    );
  }
}

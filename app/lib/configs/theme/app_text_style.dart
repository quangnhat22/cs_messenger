part of 'app_theme.dart';

class _AppTextSize {
  static const double T57 = 57;
  static const double T45 = 45;
  static const double T36 = 36;
  static const double T32 = 32;
  static const double T28 = 28;
  static const double T24 = 24;
  static const double T22 = 22;
  static const double T16 = 16;
  static const double T14 = 14;
  static const double T12 = 12;
  static const double T11 = 11;
}

class _AppTextHeight {
  static const double H57_64 = 64 / 57;
  static const double H45_52 = 52 / 45;
  static const double H36_44 = 44 / 36;
  static const double H32_40 = 40 / 32;
  static const double H28_36 = 36 / 28;
  static const double H24_32 = 32 / 24;
  static const double H22_28 = 28 / 22;
  static const double H16_24 = 24 / 16;
  static const double H14_20 = 20 / 14;
  static const double H12_16 = 16 / 12;
  static const double H11_16 = 16 / 11;
}

class _AppLetterSpacing {
  static double S05 = 0.5;
  static double S04 = 0.4;
  static double S025 = 0.25;
  static double S015 = 0.15;
  static double S01 = 0.1;
  static double S_025 = -0.25;
}

abstract class _AppTextStyle {
  static FontWeight get bold => FontWeight.w700;

  static FontWeight get semiBold => FontWeight.w600;

  static FontWeight get medium => FontWeight.w500;

  static FontWeight get regular => FontWeight.w400;

  //config textTheme for default app
  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: _textDisplayLarge,
      displayMedium: _textDisplayMedium,
      displaySmall: _textDisplaySmall,
      headlineLarge: _textHeadlineLarge,
      headlineMedium: _textHeadlineMedium,
      headlineSmall: _textHeadlineSmall,
      titleLarge: _textTitleLarge,
      titleMedium: _textTitleMedium,
      titleSmall: _textTitleSmall,
      labelLarge: _textLabelLarge,
      labelMedium: _textLabelMedium,
      labelSmall: _textLabelSmall,
      bodyLarge: _textBodyLarge,
      bodyMedium: _textBodyMedium,
      bodySmall: _textBodySmall,
    );
  }

  static final TextStyle _textDisplayLarge = TextStyle(
      fontSize: _AppTextSize.T57,
      height: _AppTextHeight.H57_64,
      fontWeight: regular,
      letterSpacing: _AppLetterSpacing.S_025);

  static final TextStyle _textDisplayMedium = TextStyle(
    fontSize: _AppTextSize.T45,
    height: _AppTextHeight.H45_52,
    fontWeight: regular,
  );

  static final TextStyle _textDisplaySmall = TextStyle(
    fontSize: _AppTextSize.T36,
    height: _AppTextHeight.H36_44,
    fontWeight: regular,
  );

  static final TextStyle _textHeadlineLarge = TextStyle(
    fontSize: _AppTextSize.T32,
    height: _AppTextHeight.H32_40,
    fontWeight: regular,
  );

  static final TextStyle _textHeadlineMedium = TextStyle(
    fontSize: _AppTextSize.T28,
    height: _AppTextHeight.H28_36,
    fontWeight: regular,
  );

  static final TextStyle _textHeadlineSmall = TextStyle(
    fontSize: _AppTextSize.T24,
    height: _AppTextHeight.H24_32,
    fontWeight: regular,
  );

  static final TextStyle _textTitleLarge = TextStyle(
    fontSize: _AppTextSize.T22,
    height: _AppTextHeight.H22_28,
    fontWeight: regular,
  );

  static final TextStyle _textTitleMedium = TextStyle(
    fontSize: _AppTextSize.T16,
    height: _AppTextHeight.H16_24,
    fontWeight: medium,
    letterSpacing: _AppLetterSpacing.S015,
  );

  static final TextStyle _textTitleSmall = TextStyle(
    fontSize: _AppTextSize.T14,
    height: _AppTextHeight.H14_20,
    fontWeight: medium,
    letterSpacing: _AppLetterSpacing.S01,
  );

  static final TextStyle _textLabelLarge = TextStyle(
    fontSize: _AppTextSize.T14,
    height: _AppTextHeight.H14_20,
    fontWeight: regular,
    letterSpacing: _AppLetterSpacing.S01,
  );

  static final TextStyle _textLabelMedium = TextStyle(
    fontSize: _AppTextSize.T12,
    height: _AppTextHeight.H12_16,
    fontWeight: medium,
    letterSpacing: _AppLetterSpacing.S05,
  );

  static final TextStyle _textLabelSmall = TextStyle(
    fontSize: _AppTextSize.T11,
    height: _AppTextHeight.H11_16,
    fontWeight: medium,
    letterSpacing: _AppLetterSpacing.S05,
  );

  static final TextStyle _textBodyLarge = TextStyle(
    fontSize: _AppTextSize.T16,
    height: _AppTextHeight.H16_24,
    fontWeight: regular,
    letterSpacing: _AppLetterSpacing.S05,
  );

  static final TextStyle _textBodyMedium = TextStyle(
    fontSize: _AppTextSize.T14,
    height: _AppTextHeight.H14_20,
    fontWeight: regular,
    letterSpacing: _AppLetterSpacing.S025,
  );

  static final TextStyle _textBodySmall = TextStyle(
    fontSize: _AppTextSize.T12,
    height: _AppTextHeight.H12_16,
    fontWeight: regular,
    letterSpacing: _AppLetterSpacing.S04,
  );
}

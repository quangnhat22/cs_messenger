part of '../app_theme.dart';

abstract class AppColorPalette {
  factory AppColorPalette(Brightness brightness) {
    if (brightness == Brightness.dark) {
      //TODO: support for dark mode
      return AppLightColorsPaletteExt();
    }
    return AppLightColorsPaletteExt();
  }

  static AppColorPalette get of =>
      AppColorPalette(PlatformDispatcher.instance.platformBrightness);

  Brightness get brightness;

  MaterialColor get primaryColor;

  MaterialColor get secondaryColor;

  MaterialColor get tertiaryColor;

  MaterialColor get errorColor;

  MaterialColor get neutralColor;

  MaterialColor get neutralVariant;

  MaterialColor get grayColor;

  MaterialColor get redColor;

  MaterialColor get greenColor;
}

class AppLightColorsPaletteExt implements AppColorPalette {
  @override
  Brightness get brightness => Brightness.light;

  @override
  MaterialColor get primaryColor => const MaterialColor(
        0xFF0060A8,
        {
          0: Color(0xFF000000),
          5: Color(0xFF001126),
          10: Color(0xFF001C38),
          20: Color(0xFF00315B),
          25: Color(0xFF003D6D),
          30: Color(0xFF004880),
          35: Color(0xFF005494),
          40: Color(0XFF0060A8),
          50: Color(0xFF287AC8),
          60: Color(0XFF4A94E4),
          70: Color(0xFF6AAEFF),
          80: Color(0XFFA2C9FF),
          90: Color(0xFFD3E4FF),
          95: Color(0xFFEAF1FF),
          98: Color(0xFFF8F9FF),
          99: Color(0xFFFDFCFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get secondaryColor => const MaterialColor(
        0xFF545F70,
        {
          0: Color(0xFF000000),
          5: Color(0xFF061120),
          10: Color(0xFF101C2B),
          20: Color(0xFF263141),
          25: Color(0xFF313C4C),
          30: Color(0xFF3C4858),
          35: Color(0xFF485364),
          40: Color(0XFF545F70),
          50: Color(0xFF6C788A),
          60: Color(0XFF8691A4),
          70: Color(0xFFA0ACBF),
          80: Color(0XFFBBC7DB),
          90: Color(0xFFD7E3F8),
          95: Color(0xFFEAF1FF),
          98: Color(0xFFF8F9FF),
          99: Color(0xFFFDFCFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get tertiaryColor => const MaterialColor(
        0xFF6C5677,
        {
          0: Color(0xFF000000),
          5: Color(0xFF1A0925),
          10: Color(0xFF261431),
          20: Color(0xFF3C2947),
          25: Color(0xFF473453),
          30: Color(0xFF533F5E),
          35: Color(0xFF604B6B),
          40: Color(0XFF6C5677),
          50: Color(0xFF866F91),
          60: Color(0XFFA088AC),
          70: Color(0xFFBCA2C7),
          80: Color(0XFFD8BDE3),
          90: Color(0xFFF4D9FF),
          95: Color(0xFFFCECFF),
          98: Color(0xFFFFF7FC),
          99: Color(0xFFFFFBFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get errorColor => const MaterialColor(
        0xFFF5222D,
        {
          0: Color(0xFF000000),
          5: Color(0xFF2D0001),
          10: Color(0xFF410002),
          20: Color(0xFF690005),
          25: Color(0xFF7E0007),
          30: Color(0xFF93000A),
          35: Color(0xFFA80710),
          40: Color(0XFFBA1A1A),
          50: Color(0xFFF5222D),
          60: Color(0XFFFF5449),
          70: Color(0xFFFF897D),
          80: Color(0XFFFFB4AB),
          90: Color(0xFFFFDAD6),
          95: Color(0xFFFFEDEA),
          98: Color(0xFFFFF8F7),
          99: Color(0xFFFFFBFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get neutralColor => const MaterialColor(
        0XFF5D5E61,
        {
          0: Color(0xFF000000),
          5: Color(0xFF0F1114),
          10: Color(0xFF1A1C1E),
          20: Color(0xFF2F3033),
          25: Color(0xFF3A3B3E),
          30: Color(0xFF46474A),
          35: Color(0xFF515255),
          40: Color(0XFF5D5E61),
          50: Color(0xFF76777A),
          60: Color(0XFF909094),
          70: Color(0xFFABABAE),
          80: Color(0XFFC6C6CA),
          90: Color(0xFFE3E2E6),
          95: Color(0xFFF1F0F4),
          98: Color(0xFFFAF9FD),
          99: Color(0xFFFDFCFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get neutralVariant => const MaterialColor(
        0XFF5A5E66,
        {
          0: Color(0xFF000000),
          5: Color(0xFF0D1117),
          10: Color(0xFF181C22),
          20: Color(0xFF2C3137),
          25: Color(0xFF3A3B3E),
          30: Color(0xFF43474E),
          35: Color(0xFF4E535A),
          40: Color(0XFF5A5E66),
          50: Color(0xFF73777F),
          60: Color(0XFF8D9199),
          70: Color(0xFFA8ABB4),
          80: Color(0XFFC3C6CF),
          90: Color(0xFFDFE2EB),
          95: Color(0xFFEEF1FA),
          98: Color(0xFFF8F9FF),
          99: Color(0xFFFDFCFF),
          100: Color(0xFFFFFFFF),
        },
      );

  @override
  MaterialColor get grayColor => const MaterialColor(
        0xFF000D0B,
        {
          1: Color(0xFFFFFFFF),
          2: Color(0xFFF5F6FA),
          3: Color(0xFFEBECF0),
          4: Color(0xFFD4D5D9),
          5: Color(0xFFBBBCBF),
          6: Color(0xFF8A8B8C),
          7: Color(0xFF575859),
          8: Color(0xFF414142),
          9: Color(0xFF2A2A2B),
          10: Color(0xFF000D0B),
        },
      );

  @override
  MaterialColor get redColor => const MaterialColor(
        0xFFF5222D,
        {
          1: Color(0xFFFEE9EA),
          2: Color(0xFFFDCED1),
          3: Color(0xFFFB9CA0),
          4: Color(0xFFF8646C),
          5: Color(0xFFF5222D),
          6: Color(0xFFC91C25),
          7: Color(0xFF9A151C),
          8: Color(0xFF7B1117),
          9: Color(0xFF580C10),
          10: Color(0xFF42090C),
        },
      );

  @override
  MaterialColor get greenColor => const MaterialColor(
        0xFF2FE2B1,
        {
          1: Color(0xFFE5F6E5),
          2: Color(0xFFC7EAC7),
          3: Color(0xFF8CD58C),
          4: Color(0xFF4CBD4C),
          5: Color(0xFF00A100),
          6: Color(0xFF008302),
          7: Color(0xFF006604),
          8: Color(0xFF005006),
          9: Color(0xFF003908),
          10: Color(0xFF002B09),
        },
      );
}

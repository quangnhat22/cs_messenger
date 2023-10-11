part of 'app_theme.dart';

class AppButtonStyle {
  static ButtonStyle? get filledButtonStyle => ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(3)),
          ),
        ),
        iconSize: MaterialStateProperty.resolveWith<double?>(
          (Set<MaterialState> states) => AppSizeExt.of.majorScale(4),
        ),
      );

  static ButtonStyle? get filledButtonDangerStyle =>
      filledButtonStyle?.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.errorColor;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) => AppColorPalette.of.redColor[6],
        ),
      );

  static ButtonStyle? get textButtonStyle => ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(1)),
          ),
        ),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.primaryColor[6];
            }
            return AppColorPalette.of.primaryColor;
          },
        ),
        iconSize: MaterialStateProperty.resolveWith<double?>(
          (Set<MaterialState> states) => AppSizeExt.of.majorScale(4),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.primaryColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.primaryColor;
          },
        ),
      );

  static ButtonStyle? get textButtonDangerStyle => textButtonStyle?.copyWith(
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.errorColor;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.errorColor;
          },
        ),
      );

  static ButtonStyle? get outlinedButtonStyle => ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(3)),
          ),
        ),
        iconSize: MaterialStateProperty.resolveWith<double?>(
          (Set<MaterialState> states) => AppSizeExt.of.majorScale(4),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          //TODO: set bg color change
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.grayColor[1];
          },
        ),
      );

  static ButtonStyle? get outlinedButtonDangerStyle =>
      outlinedButtonStyle?.copyWith(
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return BorderSide(color: AppColorPalette.of.redColor[6]!);
            }
            if (states.contains(MaterialState.hovered)) {
              return BorderSide(color: AppColorPalette.of.redColor[6]!);
            }
            if (states.contains(MaterialState.pressed)) {
              return BorderSide(color: AppColorPalette.of.redColor[6]!);
            }
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: AppColorPalette.of.grayColor[3]!);
            }
            return BorderSide(color: AppColorPalette.of.errorColor);
          },
        ),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.errorColor;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColorPalette.of.redColor[6];
            }
            if (states.contains(MaterialState.disabled)) {
              return AppColorPalette.of.grayColor[5];
            }
            return AppColorPalette.of.errorColor;
          },
        ),
      );
}

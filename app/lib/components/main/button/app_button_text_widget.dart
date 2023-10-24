part of 'app_button_base_builder.dart';

class AppButtonTextWidget extends AppButtonBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_prefixIcon == null && _buttonText == null) return const SizedBox();
    return _standard(context);
  }

  Widget _standard(BuildContext context) {
    return TextButton(
      onPressed: _isDisable == true ? null : _onPressed,
      style: _buttonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_prefixIcon != null) _prefixIcon!,
          if (_prefixIcon != null && _buttonText != null)
            SizedBox(width: AppSizeExt.of.majorPaddingScale(2)),
          if (_buttonText != null)
            AppTextBodyLargeWidget()
                .setText(_buttonText!)
                .setTextStyle(_textStyle)
                .build(context),
          if (_suffixIcon != null)
            SizedBox(width: AppSizeExt.of.majorPaddingScale(2)),
          if (_suffixIcon != null) _suffixIcon!,
        ],
      ),
    );
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    double horizontalPadding = AppSizeExt.of.majorScale(4);
    double verticalPadding = AppSizeExt.of.majorScale(3);
    TextStyle? textStyle = _textStyle ?? Theme.of(context).textTheme.bodyMedium;

    if (_appButtonSize == AppButtonSize.medium) {
      verticalPadding = AppSizeExt.of.majorScale(2);
    }
    if (_appButtonSize == AppButtonSize.small) {
      verticalPadding = AppSizeExt.of.majorScale(1);
    }

    if (_appButtonType == AppButtonType.danger) {
      return AppButtonStyle.textButtonDangerStyle?.copyWith(
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
          (Set<MaterialState> states) => EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return textStyle?.copyWith(
                  decorationColor: AppColorPalette.of.redColor[6]);
            }
            if (states.contains(MaterialState.hovered)) {
              return textStyle?.copyWith(
                  decorationColor: AppColorPalette.of.redColor[6]);
            }
            if (states.contains(MaterialState.pressed)) {
              return textStyle?.copyWith(
                  decorationColor: AppColorPalette.of.redColor[6]);
            }
            if (states.contains(MaterialState.disabled)) {
              return textStyle?.copyWith(
                  decorationColor: AppColorPalette.of.grayColor[5]);
            }
            return textStyle?.copyWith(
                decorationColor: AppColorPalette.of.errorColor);
          },
        ),
      );
    }

    return Theme.of(context).textButtonTheme.style?.copyWith(
          padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
            (Set<MaterialState> states) => EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return textStyle?.copyWith(
                  decorationColor: AppColorPalette.of.grayColor[5],
                );
              }
            },
          ),
        );
  }

  @override
  AppButtonBaseBuilder setAppButtonSize(AppButtonSize? appButtonSize) {
    _appButtonSize = appButtonSize;
    return this;
  }

  @override
  AppButtonTextWidget setAppButtonType(AppButtonType? appButtonType) {
    _appButtonType = appButtonType;
    return this;
  }

  @override
  AppButtonTextWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppButtonTextWidget setIsDisable(bool? isDisable) {
    _isDisable = isDisable;
    return this;
  }

  @override
  AppButtonTextWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppButtonTextWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppButtonTextWidget setSuffixIcon(Widget? suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }

  @override
  AppButtonTextWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @Deprecated('It\'s not working! Please using it with [AppButtonFilledWidget]')
  @override
  AppButtonTextWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }
}

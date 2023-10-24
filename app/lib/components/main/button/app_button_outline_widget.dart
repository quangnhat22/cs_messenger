part of 'app_button_base_builder.dart';

class AppButtonOutlineWidget extends AppButtonBaseBuilder {
  Color? _borderColor;

  @override
  Widget build(BuildContext context) {
    if (_prefixIcon == null && _buttonText == null) return const SizedBox();
    if (_appButtonType == AppButtonType.circle) {
      return _circle(context);
    }
    if (_appButtonType == AppButtonType.square) {
      return _square(context);
    }
    return _standard(context);
  }

  Widget _standard(BuildContext context) {
    return OutlinedButton(
      onPressed: _isDisable == true ? null : _onPressed,
      style: _buttonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_prefixIcon != null) _prefixIcon!,
          if (_prefixIcon != null && _buttonText != null)
            SizedBox(width: AppSizeExt.of.majorPaddingScale(2)),
          if (_buttonText != null)
            AppTextBodyLargeWidget()
                .setText(_buttonText!)
                // .setTextStyle(_textStyle)
                .setColor(
                    _textStyle?.color ?? Theme.of(context).colorScheme.primary)
                .build(context),
          // if (_suffixIcon != null)
          //   SizedBox(width: AppSizeExt.of.majorPaddingScale(2)),
          if (_suffixIcon != null) _suffixIcon!,
        ],
      ),
    );
  }

  Widget _circle(BuildContext context) {
    double buttonPadding = AppSizeExt.of.majorScale(13 / 4);

    if (_appButtonSize == AppButtonSize.small) {
      buttonPadding = AppSizeExt.of.majorScale(5 / 4);
    }

    return _prefixIcon != null
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorPalette.of.grayColor[1],
              border: Border.all(color: AppColorPalette.of.grayColor[4]!),
            ),
            child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: _onPressed,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSizeExt.of.majorScale(6))),
                child: Container(
                  padding: EdgeInsets.all(buttonPadding),
                  child: _prefixIcon,
                )),
          )
        : Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorPalette.of.grayColor[1],
                border: Border.all(color: AppColorPalette.of.grayColor[4]!)),
            child: InkWell(
              onTap: _onPressed,
              splashFactory: NoSplash.splashFactory,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeExt.of.majorScale(1))),
              child: Container(
                padding: EdgeInsets.all(buttonPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextBodyLargeWidget()
                        .setText(_buttonText!)
                        .setTextStyle(_textStyle)
                        .setColor(Theme.of(context).colorScheme.primary)
                        .build(context)
                  ],
                ),
              ),
            ),
          );
  }

  Widget _square(BuildContext context) {
    double width = AppSizeExt.of.majorScale(12);
    double height = AppSizeExt.of.majorScale(12);
    double horizontalPadding = AppSizeExt.of.majorScale(3);
    if (_appButtonSize == AppButtonSize.medium) {
      width = AppSizeExt.of.majorScale(10);
      height = AppSizeExt.of.majorScale(10);
      horizontalPadding = AppSizeExt.of.majorScale(2);
    }
    if (_appButtonSize == AppButtonSize.small) {
      width = AppSizeExt.of.majorScale(8);
      height = AppSizeExt.of.majorScale(8);
      horizontalPadding = AppSizeExt.of.majorScale(1);
    }

    return SizedBox(
      width: width,
      height: height,
      child: _prefixIcon != null
          ? OutlinedButton(
              onPressed: _isDisable == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                    (Set<MaterialState> states) =>
                        EdgeInsets.symmetric(horizontal: horizontalPadding)),
              ),
              child: _prefixIcon!,
            )
          : OutlinedButton(
              onPressed: _isDisable == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                    (Set<MaterialState> states) =>
                        EdgeInsets.symmetric(horizontal: horizontalPadding)),
              ),
              child: AppTextBodyLargeWidget()
                  .setText(_buttonText!)
                  .setTextStyle(_textStyle)
                  .build(context),
            ),
    );
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    double horizontalPadding = AppSizeExt.of.majorScale(4);
    double verticalPadding = AppSizeExt.of.majorScale(9 / 4);
    TextStyle? textStyle = _textStyle;

    if (_appButtonSize == AppButtonSize.medium) {
      horizontalPadding = AppSizeExt.of.majorScale(3);
      verticalPadding = AppSizeExt.of.majorScale(5 / 4);
      textStyle = _textStyle ?? Theme.of(context).textTheme.bodyMedium;
    }
    if (_appButtonType == AppButtonType.danger) {
      return AppButtonStyle.outlinedButtonDangerStyle?.copyWith(
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
          (Set<MaterialState> states) => EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) => textStyle,
        ),
      );
    }
    return Theme.of(context).outlinedButtonTheme.style?.copyWith(
          padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
            (Set<MaterialState> states) => EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) => textStyle,
          ),
          side: _borderColor != null
              ? MaterialStateProperty.all(BorderSide(
                  color: _borderColor!, width: 1.0, style: BorderStyle.solid))
              : null,
        );
  }

  AppButtonOutlineWidget setBorderColor(Color? borderColor) {
    _borderColor = borderColor;
    return this;
  }

  @override
  AppButtonOutlineWidget setAppButtonSize(AppButtonSize? appButtonSize) {
    _appButtonSize = appButtonSize;
    return this;
  }

  @override
  AppButtonOutlineWidget setAppButtonType(AppButtonType? appButtonType) {
    _appButtonType = appButtonType;
    return this;
  }

  @override
  AppButtonOutlineWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppButtonOutlineWidget setIsDisable(bool? isDisable) {
    _isDisable = isDisable;
    return this;
  }

  @override
  AppButtonOutlineWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppButtonOutlineWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppButtonOutlineWidget setSuffixIcon(Widget? suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }

  @override
  AppButtonOutlineWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @Deprecated('It\'s not working! Please using it with [AppButtonFilledWidget]')
  @override
  AppButtonOutlineWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }
}

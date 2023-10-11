part of 'app_button_base_builder.dart';

class AppButtonFilledWidget extends AppButtonBaseBuilder {
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
    return FilledButton(
      onPressed: _isDisable == true ? null : _onPressed,
      style: _buttonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (_prefixIcon != null) _prefixIcon!,
          // if (_prefixIcon != null && _buttonText != null)
          //   SizedBox(width: AppSizeExt.of.majorScale(6 / 4)),
          if (_buttonText != null)
            AppTextBodyLargeWidget()
                .setTextStyle(_textStyle)
                .setColor(Theme.of(context).colorScheme.surfaceVariant)
                .setText(_buttonText!)
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
              color: Theme.of(context).colorScheme.primary,
            ),
            child: InkWell(
              onTap: _onPressed,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizeExt.of.majorScale(7)),
              ),
              child: Container(
                padding: EdgeInsets.all(buttonPadding),
                child: _prefixIcon,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppSizeExt.of.majorScale(5),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(buttonPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextBodyLargeWidget()
                        .setText(_buttonText!)
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
          ? FilledButton(
              onPressed: _isDisable == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                  (Set<MaterialState> states) =>
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                ),
              ),
              child: _prefixIcon!,
            )
          : FilledButton(
              onPressed: _isDisable == true ? null : _onPressed,
              style: _buttonStyle(context)?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
                  (Set<MaterialState> states) =>
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                ),
              ),
              child: AppTextBodyLargeWidget()
                  .setText(_buttonText!)
                  .setColor(AppColorPalette.of.grayColor[1])
                  .build(context),
            ),
    );
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    double horizontalPadding = AppSizeExt.of.majorScale(4);
    double verticalPadding = AppSizeExt.of.majorScale(9 / 4);

    final textColor = Theme.of(context).colorScheme.surfaceVariant;

    TextStyle? textStyle = _textStyle?.copyWith(color: textColor) ??
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor);

    if (_appButtonSize == AppButtonSize.medium) {
      horizontalPadding = AppSizeExt.of.majorScale(3);
      verticalPadding = AppSizeExt.of.majorScale(5 / 4);
    }
    if (_appButtonType == AppButtonType.danger) {
      return AppButtonStyle.filledButtonDangerStyle?.copyWith(
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
          (Set<MaterialState> states) => EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
          (Set<MaterialState> states) => textStyle,
        ),
      );
    }
    return Theme.of(context).filledButtonTheme.style?.copyWith(
          padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
            (Set<MaterialState> states) => EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) => textStyle,
          ),
        );
  }

  @override
  AppButtonFilledWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppButtonFilledWidget setIsDisable(bool? isDisable) {
    _isDisable = isDisable;
    return this;
  }

  @override
  AppButtonFilledWidget setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  @override
  AppButtonFilledWidget setPrefixIcon(Widget? prefixIcon) {
    _prefixIcon = prefixIcon;
    return this;
  }

  @override
  AppButtonFilledWidget setSuffixIcon(Widget? suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }

  @override
  AppButtonFilledWidget setTextStyle(TextStyle? textStyle) {
    _textStyle = textStyle;
    return this;
  }

  @override
  AppButtonFilledWidget setAppButtonSize(AppButtonSize? appButtonSize) {
    _appButtonSize = appButtonSize;
    return this;
  }

  /// If you want to set `circle` for [AppButtonFilledWidget]
  /// please set `iconColor: Theme.of(context).colorScheme.surfaceVariant`, unless it is "black"
  @override
  AppButtonFilledWidget setAppButtonType(AppButtonType? appButtonType) {
    _appButtonType = appButtonType;
    return this;
  }
}

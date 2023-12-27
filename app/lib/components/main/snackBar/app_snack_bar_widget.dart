part of 'app_snack_bar_base_builder.dart';

class AppSnackBarWidget extends AppSnackBarBaseBuilder {
  @override
  void showSnackBar() async {
    final context = AppKeys.navigatorKey.currentContext;

    if (context == null) return;

    final snackBar = _buildSnackBar(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showSnackBarWithContext(BuildContext context) async {
    final snackBar = _buildSnackBar(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  SnackBar _buildSnackBar(BuildContext context) {
    return SnackBar(
      margin: _marginSnackBar ??
          EdgeInsets.only(
            bottom: AppSizeExt.of.majorMarginScale(4),
            left: AppSizeExt.of.majorMarginScale(4),
            right: AppSizeExt.of.majorMarginScale(4),
          ),
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 4),
      content: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          border: Border.all(
            color: _getBorderColor(context)!, // Set the border color
            width: 1.0, // Set the border width
          ),
          borderRadius: BorderRadius.circular(
            AppSizeExt.of.majorScale(1),
          ), // Set the border radius
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(3)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: AppSizeExt.of.majorMarginScale(2 / 4)),
                  child: _prefixWidget ?? getPrefixIcon!),
              SizedBox(
                width: AppSizeExt.of.majorPaddingScale(2),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_appSnackBarType == AppSnackBarType.informMessage)
                      AppTextBodySmallWidget()
                          .setText(_labelText)
                          .setTextStyle(
                              const TextStyle(fontWeight: FontWeight.bold))
                          .setColor(Theme.of(context).colorScheme.onBackground)
                          .build(context),
                    // _content ?? const SizedBox()
                  ],
                ),
              ),
              // _suffixWidget ??
              //     (_appSnackBarType == AppSnackBarType.informMessage
              //         ? AppButtonOutlineWidget()
              //             .setButtonText(_buttonText ?? R.strings.gotIt)
              //             .setAppButtonType(getSuffixButtonType)
              //             .setAppButtonSize(AppButtonSize.small)
              //             .setOnPressed(() {
              //             _onPress?.call();
              //             getIt<AppRouter>().pop();
              //           }).build(context)
              //         : InkWell(
              //             onTap: () {
              //               _onPress?.call();
              //               getIt<AppRouter>().pop();
              //             },
              //             customBorder: const CircleBorder(),
              //             splashColor: AppColorPalette.of.grayColor[3],
              //             child: Icon(
              //               Icons.close,
              //               size: AppSizeExt.of.majorScale(18 / 4),
              //             ),
              //           )),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2);
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return Colors.yellow;
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return AppColorPalette.of.redColor[1];
    } else {
      return AppColorPalette.of.greenColor[1];
    }
  }

  Color? _getBorderColor(BuildContext context) {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return Theme.of(context).colorScheme.primaryContainer;
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return Colors.yellow[800];
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return AppColorPalette.of.redColor[3];
    } else {
      return AppColorPalette.of.greenColor[3];
    }
  }

  Widget? get getPrefixIcon {
    if (_appSnackBarStatus == AppSnackBarStatus.info) {
      return R.svgs.icFilledInfoCircle.svg();
    } else if (_appSnackBarStatus == AppSnackBarStatus.warning) {
      return R.svgs.icWarningCircle.svg();
    } else if (_appSnackBarStatus == AppSnackBarStatus.error) {
      return R.svgs.icErrorCircle.svg();
    } else {
      return R.svgs.icSuccessCircle.svg();
    }
  }

  AppButtonType? get getSuffixButtonType =>
      _appSnackBarStatus == AppSnackBarStatus.error
          ? AppButtonType.danger
          : AppButtonType.standard;

  @override
  AppSnackBarWidget setAppSnackBarStatus(AppSnackBarStatus? appSnackBarStatus) {
    _appSnackBarStatus = appSnackBarStatus;
    return this;
  }

  @override
  AppSnackBarWidget setAppSnackBarType(AppSnackBarType? appSnackBarType) {
    _appSnackBarType = appSnackBarType;
    return this;
  }

  @override
  AppSnackBarWidget setContent(Widget? content) {
    _content = content;
    return this;
  }

  @override
  AppSnackBarWidget setLabelText(String? labelText) {
    _labelText = labelText;
    return this;
  }

  @override
  AppSnackBarWidget setOnPress(void Function()? onPress) {
    _onPress = onPress;
    return this;
  }

  @override
  AppSnackBarWidget setPrefixWidget(Widget? prefixWidget) {
    _prefixWidget = prefixWidget;
    return this;
  }

  @Deprecated('Please don\'t use it')
  @override
  AppSnackBarWidget setSuffixWidget(Widget? suffixWidget) {
    _suffixWidget = suffixWidget;
    return this;
  }

  @override
  AppSnackBarWidget setButtonText(String? buttonText) {
    _buttonText = buttonText;
    return this;
  }

  @override
  AppSnackBarWidget setMarginSnackBar(EdgeInsets? marginSnackBar) {
    _marginSnackBar = marginSnackBar;
    return this;
  }

  @override
  AppSnackBarWidget setBehavior(SnackBarBehavior? behavior) {
    _behavior = behavior;
    return this;
  }
}

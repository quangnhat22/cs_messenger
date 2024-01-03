part of 'app_dialog_base_builder.dart';

class AppDialogRequestWidget extends AppDialogBaseBuilder {
  Widget? _topWidget;

  @override
  AppDialogBaseBuilder buildDialog(BuildContext context) {
    _dialog = Dialog(
      insetPadding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(6)),
      child: Stack(
        children: [
          _buildContentDialog(context),
          if (_isHaveCloseIcon == true)
            Positioned(
              top: AppSizeExt.of.majorScale(2 / 4),
              right: AppSizeExt.of.majorScale(2),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  await getIt<AppRouter>().pop();
                },
              ),
            )
        ],
      ),
    );
    return this;
  }

  Widget _buildContentDialog(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizeExt.of.majorScale(10),
        ),
      ),
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: AppSizeExt.of.majorScale(2)),
          if (_topWidget != null) _topWidget!,
          if (_title != null)
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppSizeExt.of.majorScale(3)),
              child: AppTextHeadlineSmallWidget()
                  .setText(_title)
                  .setTextAlign(TextAlign.center)
                  .build(context),
            ),
          if (_contentWidget != null) _contentWidget!,
          if (_content != null)
            AppTextBodyLargeWidget()
                .setText(_content)
                // .setTextStyle(AppTextStyleExt.of.textBody1r)
                .setTextAlign(TextAlign.center)
                .build(context),
          SizedBox(height: AppSizeExt.of.majorScale(6)),
          if (_textField != null) _textField!,
          if (_textField != null) SizedBox(height: AppSizeExt.of.majorScale(6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (_negativeText != null)
                Expanded(
                  child: AppButtonOutlineWidget()
                      .setButtonText(_negativeText)
                      .setBorderColor(Theme.of(context).colorScheme.primary)
                      .setOnPressed(() async {
                    await getIt<AppRouter>().pop();
                    _onNegative?.call();
                  }).build(context),
                ),
              if (_negativeText != null)
                SizedBox(width: AppSizeExt.of.majorScale(3)),
              if (_positiveText != null)
                _appDialogButtonType == AppDialogButtonType.danger
                    ? Expanded(
                        child: AppButtonFilledWidget()
                            .setButtonText(_positiveText)
                            .setTextStyle(TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background))
                            .setAppButtonSize(AppButtonSize.large)
                            .setAppButtonType(AppButtonType.danger)
                            .setOnPressed(() async {
                          await getIt<AppRouter>().pop();
                          _onPositive?.call();
                        }).build(context),
                      )
                    : Expanded(
                        child: AppButtonFilledWidget()
                            .setButtonText(_positiveText)
                            .setTextStyle(TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background))
                            .setOnPressed(() async {
                          await getIt<AppRouter>().pop();
                          _onPositive?.call();
                        }).build(context),
                      ),
            ],
          )
        ],
      ),
    );
  }

  AppDialogRequestWidget setTopWidget(Widget? topWidget) {
    _topWidget = topWidget;
    return this;
  }

  @override
  AppDialogRequestWidget setAppDialogButtonType(
      AppDialogButtonType? appDialogButtonType) {
    _appDialogButtonType = appDialogButtonType;
    return this;
  }

  @override
  AppDialogRequestWidget setAppDialogType(AppDialogType? type) {
    _appDialogType = type;
    return this;
  }

  @override
  AppDialogRequestWidget setContent(String? content) {
    _content = content;
    return this;
  }

  @override
  AppDialogRequestWidget setContentWidget(Widget? contentWidget) {
    _contentWidget = contentWidget;
    return this;
  }

  @override
  AppDialogRequestWidget setIcon(Widget? icon) {
    _icon = icon;
    return this;
  }

  @override
  AppDialogRequestWidget setIsHaveCloseIcon(bool? isHaveCloseIcon) {
    _isHaveCloseIcon = isHaveCloseIcon;
    return this;
  }

  @override
  AppDialogRequestWidget setNegativeText(String? negativeText) {
    _negativeText = negativeText;
    return this;
  }

  @override
  AppDialogRequestWidget setOnNegative(void Function()? onNegative) {
    _onNegative = onNegative;
    return this;
  }

  @override
  AppDialogRequestWidget setOnPositive(void Function()? onPositive) {
    _onPositive = onPositive;
    return this;
  }

  @override
  AppDialogRequestWidget setPositiveText(String? positiveText) {
    _positiveText = positiveText;
    return this;
  }

  @override
  AppDialogRequestWidget setTextField(Widget? textField) {
    _textField = textField;
    return this;
  }

  @override
  AppDialogRequestWidget setTitle(String? title) {
    _title = title;
    return this;
  }
}

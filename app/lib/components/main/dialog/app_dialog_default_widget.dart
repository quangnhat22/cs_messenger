part of 'app_dialog_base_builder.dart';

class AppDefaultDialogWidget extends AppDialogBaseBuilder {
  @override
  AppDialogBaseBuilder buildDialog(BuildContext context) {
    if (_appDialogType == null) {
      throw Exception('appDialogType null!');
    }

    switch (_appDialogType!) {
      case AppDialogType.success:
        setIcon(R.svgs.icSuccess.svg());
        break;
      case AppDialogType.error:
        setIcon(R.svgs.icError.svg());
        break;
      case AppDialogType.confirm:
        setIcon(R.svgs.icWarning.svg());
        break;
      default:
        throw Exception('appDialogType null!');
    }

    _dialog = Dialog(
      insetPadding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(6)),
      child: Stack(
        children: [
          _buildContentDialog(context),
          if (_isHaveCloseIcon == true)
            Positioned(
              right: AppSizeExt.of.majorScale(2),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.router.pop();
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
          if (_icon != null) _icon!,
          if (_title != null)
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppSizeExt.of.majorScale(3)),
              child: AppTextHeadlineSmallWidget()
                  .setText(_title)
                  .setTextAlign(TextAlign.center)
                  .build(context),
            ),
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
                    await context.router.pop();
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
                          //TODO: implement auto route
                          await context.router.pop();
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
                          await context.router.pop();
                          _onPositive?.call();
                        }).build(context),
                      ),
            ],
          )
        ],
      ),
    );
  }

  @override
  AppDefaultDialogWidget setAppDialogButtonType(
      AppDialogButtonType? appDialogButtonType) {
    _appDialogButtonType = appDialogButtonType;
    return this;
  }

  @override
  AppDefaultDialogWidget setAppDialogType(AppDialogType? type) {
    _appDialogType = type;
    return this;
  }

  @override
  AppDefaultDialogWidget setContent(String? content) {
    _content = content;
    return this;
  }

  @override
  AppDefaultDialogWidget setContentWidget(Widget? contentWidget) {
    _contentWidget = contentWidget;
    return this;
  }

  @override
  AppDefaultDialogWidget setIcon(Widget? icon) {
    _icon = icon;
    return this;
  }

  @override
  AppDefaultDialogWidget setIsHaveCloseIcon(bool? isHaveCloseIcon) {
    _isHaveCloseIcon = isHaveCloseIcon;
    return this;
  }

  @override
  AppDefaultDialogWidget setNegativeText(String? negativeText) {
    _negativeText = negativeText;
    return this;
  }

  @override
  AppDefaultDialogWidget setOnNegative(void Function()? onNegative) {
    _onNegative = onNegative;
    return this;
  }

  @override
  AppDefaultDialogWidget setOnPositive(void Function()? onPositive) {
    _onPositive = onPositive;
    return this;
  }

  @override
  AppDefaultDialogWidget setPositiveText(String? positiveText) {
    _positiveText = positiveText;
    return this;
  }

  @override
  AppDefaultDialogWidget setTextField(Widget? textField) {
    _textField = textField;
    return this;
  }

  @override
  AppDefaultDialogWidget setTitle(String? title) {
    _title = title;
    return this;
  }
}

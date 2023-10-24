part of 'app_card_base_builder.dart';

class AppCardWidget extends AppCardBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _onTap,
          child: Card(
            surfaceTintColor:
                _backgroundColor ?? Theme.of(context).colorScheme.background,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizeExt.of.majorPaddingScale(4),
                horizontal: AppSizeExt.of.majorPaddingScale(3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (_leading != null) _leading!,
                  if (_leading != null && _subtitle != null)
                    SizedBox(width: AppSizeExt.of.majorScale(4)),
                  if (_subtitle != null) Expanded(child: _subtitle!),
                  if (_actions != null) Row(children: _actions!)
                ],
              ),
            ),
          ),
        ),
        if (_isShowBottomDivider == true)
          AppDividerSpaceLeftWidget()
              .setSpaceLeft(AppSizeExt.of.majorScale(17))
              .build(context)
      ],
    );
  }

  @override
  AppCardWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppCardWidget setLeading(Widget? leading) {
    _leading = leading;
    return this;
  }

  @override
  AppCardWidget setOnTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  @override
  AppCardWidget setSubtitle(Widget? subtitle) {
    _subtitle = subtitle;
    return this;
  }

  @override
  AppCardWidget setTitle(Widget? title) {
    _title = title;
    return this;
  }

  @override
  AppCardWidget setActions(List<Widget>? actions) {
    _actions = actions;
    return this;
  }

  @override
  AppCardWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppCardWidget setIsShowBottomDivider(bool? isShowBottomDivider) {
    _isShowBottomDivider = isShowBottomDivider;
    return this;
  }
}

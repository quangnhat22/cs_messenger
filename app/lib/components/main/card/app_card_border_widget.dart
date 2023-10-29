part of 'app_card_base_builder.dart';

class AppCardBorderWidget extends AppCardBaseBuilder {
  bool? _hasTopBorderRadius;
  bool? _hasBottomBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: _buildTopRadius(),
              bottom: _buildBottomRadius(),
            ),
          ),
          onTap: _onTap,
          child: ListTile(
            enabled: _isDisabled ?? false,
            leading: _leading,
            title: _title,
            subtitle: _subtitle,
            trailing: _actions?[0],
          ),
        ),
        if (_isShowBottomDivider == true)
          AppDividerSpaceLeftWidget()
              .setSpaceLeft(AppSizeExt.of.majorScale(14))
              .build(context)
      ],
    );
  }

  Radius _buildTopRadius() {
    return (_hasTopBorderRadius == true)
        ? const Radius.circular(10)
        : Radius.zero;
  }

  Radius _buildBottomRadius() {
    return (_hasBottomBorderRadius == true)
        ? const Radius.circular(10)
        : Radius.zero;
  }

  AppCardBorderWidget setHasTopBorderRadius(bool? hasTopBorderRadius) {
    _hasTopBorderRadius = hasTopBorderRadius;
    return this;
  }

  AppCardBorderWidget setHasBottomBorderRadius(bool? hasBottomBorderRadius) {
    _hasBottomBorderRadius = hasBottomBorderRadius;
    return this;
  }

  @override
  AppCardBorderWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppCardBorderWidget setLeading(Widget? leading) {
    _leading = leading;
    return this;
  }

  @override
  AppCardBorderWidget setOnTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  @override
  AppCardBorderWidget setSubtitle(Widget? subtitle) {
    _subtitle = subtitle;
    return this;
  }

  @override
  AppCardBorderWidget setTitle(Widget? title) {
    _title = title;
    return this;
  }

  @override
  AppCardBorderWidget setActions(List<Widget>? actions) {
    _actions = actions;
    return this;
  }

  @override
  AppCardBorderWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppCardBorderWidget setIsShowBottomDivider(bool? isShowBottomDivider) {
    _isShowBottomDivider = isShowBottomDivider;
    return this;
  }
}

part of 'app_card_base_builder.dart';

class AppCardBorderWidget extends AppCardBaseBuilder {
  bool? _hasTopBorderRadius;
  bool? _hasBottomBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: _buildTopRadius(),
              bottom: _buildBottomRadius(),
            ),
          ),
          child: Padding(
            padding: _contentPadding ??
                EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(4),
                  horizontal: AppSizeExt.of.majorPaddingScale(3),
                ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (_leading != null) _leading!,
                if ((_leading != null && _title != null) ||
                    (_leading != null && _subtitle != null))
                  SizedBox(width: AppSizeExt.of.majorScale(4)),
                if (_title != null || _subtitle != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _title ?? const SizedBox(),
                        _subtitle ?? const SizedBox(),
                      ],
                    ),
                  ),
                if (_actions != null) Row(children: _actions!)
              ],
            ),
          ),
        ),
        if (_isShowBottomDivider == true)
          AppDividerSpaceLeftWidget()
              .setSpaceLeft(AppSizeExt.of.majorScale(12))
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

  @override
  AppCardBorderWidget setContentPadding(EdgeInsetsGeometry? contentPadding) {
    _contentPadding = contentPadding;
    return this;
  }
}

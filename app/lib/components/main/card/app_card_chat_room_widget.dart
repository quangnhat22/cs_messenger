part of 'app_card_base_builder.dart';

class AppCardChatRoomWidget extends AppCardBaseBuilder {
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
                  vertical: AppSizeExt.of.majorPaddingScale(3),
                  horizontal: AppSizeExt.of.majorPaddingScale(2),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _title ?? const SizedBox(),
                        SizedBox(height: AppSizeExt.of.majorScale(1)),
                        _subtitle ?? const SizedBox(),
                      ],
                    ),
                  ),
                if (_actions != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: _actions!,
                  )
              ],
            ),
          ),
        ),
        if (_isShowBottomDivider == true)
          AppDividerSpaceLeftWidget()
              .setSpaceLeft(AppSizeExt.of.majorScale(15))
              .build(context)
      ],
    );
  }

  Radius _buildTopRadius() {
    return (_hasTopBorderRadius == true)
        ? const Radius.circular(8)
        : Radius.zero;
  }

  Radius _buildBottomRadius() {
    return (_hasBottomBorderRadius == true)
        ? const Radius.circular(8)
        : Radius.zero;
  }

  AppCardChatRoomWidget setHasTopBorderRadius(bool? hasTopBorderRadius) {
    _hasTopBorderRadius = hasTopBorderRadius;
    return this;
  }

  AppCardChatRoomWidget setHasBottomBorderRadius(bool? hasBottomBorderRadius) {
    _hasBottomBorderRadius = hasBottomBorderRadius;
    return this;
  }

  @override
  AppCardChatRoomWidget setIsDisabled(bool? isDisabled) {
    _isDisabled = isDisabled;
    return this;
  }

  @override
  AppCardChatRoomWidget setLeading(Widget? leading) {
    _leading = leading;
    return this;
  }

  @override
  AppCardChatRoomWidget setOnTap(void Function()? onTap) {
    _onTap = onTap;
    return this;
  }

  @override
  AppCardChatRoomWidget setSubtitle(Widget? subtitle) {
    _subtitle = subtitle;
    return this;
  }

  @override
  AppCardChatRoomWidget setTitle(Widget? title) {
    _title = title;
    return this;
  }

  @override
  AppCardChatRoomWidget setActions(List<Widget>? actions) {
    _actions = actions;
    return this;
  }

  @override
  AppCardChatRoomWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppCardChatRoomWidget setIsShowBottomDivider(bool? isShowBottomDivider) {
    _isShowBottomDivider = isShowBottomDivider;
    return this;
  }

  @override
  AppCardChatRoomWidget setContentPadding(EdgeInsetsGeometry? contentPadding) {
    _contentPadding = contentPadding;
    return this;
  }

  @override
  AppCardChatRoomWidget setElevation(double? elevation) {
    _elevation = elevation;
    return this;
  }
}

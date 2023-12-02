part of 'app_bar_base_builder.dart';

class AppBarWidget extends AppBarBaseBuilder {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: AppTextHeadlineSmallWidget()
          .setText(_textTitle)
          .setTextStyle(TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ))
          .setColor(_textTitleColor)
          .build(context),
      centerTitle: _centerTitle ?? true,
      leading: _leading,
      actions: _actions,
      backgroundColor: _backgroundColor,
      flexibleSpace: _flexibleSpace,
      bottom: _bottom,
    );
  }

  @override
  AppBarWidget setActions(List<Widget>? actions) {
    _actions = actions;
    return this;
  }

  @override
  AppBarWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppBarWidget setBottom(PreferredSizeWidget? bottom) {
    _bottom = _bottom;
    return this;
  }

  @override
  AppBarWidget setFlexibleSpace(Widget? flexibleSpace) {
    _flexibleSpace = flexibleSpace;
    return this;
  }

  @override
  AppBarWidget setTextTitle(String? textTitle) {
    _textTitle = textTitle;
    return this;
  }

  @override
  AppBarWidget setTextTitleColor(Color? textTitleColor) {
    _textTitleColor = textTitleColor;
    return this;
  }

  @override
  AppBarWidget setLeading(Widget? leading) {
    _leading = leading;
    return this;
  }

  @override
  AppBarWidget setCenterTitle(bool? centerTitle) {
    _centerTitle = centerTitle;
    return this;
  }
}

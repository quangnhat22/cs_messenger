import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:flutter/material.dart';

part 'app_bar_widget.dart';

abstract class AppBarBaseBuilder {
  @protected
  String? _textTitle;
  @protected
  Widget? _textTitleWidget;
  @protected
  Color? _textTitleColor;
  @protected
  Widget? _leading;
  @protected
  bool? _centerTitle;
  @protected
  List<Widget>? _actions;
  @protected
  Color? _backgroundColor;
  @protected
  Widget? _flexibleSpace;
  @protected
  PreferredSizeWidget? _bottom;

  AppBarBaseBuilder setTextTitle(String? textTitle);

  AppBarBaseBuilder setTextTitleColor(Color? textTitleColor);

  AppBarBaseBuilder setLeading(Widget? leading);

  AppBarBaseBuilder setCenterTitle(bool? centerTitle) {
    return this;
  }

  AppBarBaseBuilder setActions(List<Widget>? actions);

  AppBarBaseBuilder setBackgroundColor(Color? backgroundColor);

  AppBarBaseBuilder setFlexibleSpace(Widget? flexibleSpace);

  AppBarBaseBuilder setBottom(PreferredSizeWidget? bottom);

  PreferredSizeWidget build(BuildContext context);

  AppBarBaseBuilder setTextTitleWidget(Widget? textTitleWidget);
}

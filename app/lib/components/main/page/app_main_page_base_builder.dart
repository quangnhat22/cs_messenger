import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'app_main_page_widget.dart';
part 'app_nested_scroll_page_widget.dart';
part 'app_stack_page_widget.dart';

abstract class AppMainPageBaseBuilder {
  @protected
  Key? _key;
  @protected
  Widget? _body;
  @protected
  PreferredSizeWidget? _appBar;
  @protected
  Widget? _endDrawer;
  @protected
  Widget? _floatActionButton;
  @protected
  Color? _backgroundColor;
  @protected
  bool? _resizeToAvoidBottomInset;
  @protected
  void Function(bool)? _onEndDrawerChanged;

  AppMainPageBaseBuilder setKey(Key? key);

  AppMainPageBaseBuilder setAppBar(PreferredSizeWidget? appBar);

  AppMainPageBaseBuilder setBody(Widget? body);

  AppMainPageBaseBuilder setEndDrawer(Widget? endDrawer);

  AppMainPageBaseBuilder setBackgroundColor(Color? backgroundColor);

  AppMainPageBaseBuilder setEndDrawerChanged(
      void Function(bool)? onEndDrawerChanged);

  AppMainPageBaseBuilder setResizeToAvoidBottomInset(
      bool? resizeToAvoidBottomInset);

  AppMainPageBaseBuilder setFloatActionButton(Widget? floatActionButton);

  Widget build(BuildContext context);
}

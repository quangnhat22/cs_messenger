import 'package:flutter/material.dart';

part 'app_tab_text_only_widget.dart';

abstract class AppTabBaseBuilder {
  @protected
  List<String>? _tabTitleList;
  @protected
  List<Widget>? _tabNumberList;
  @protected
  List<Widget>? _tabDefaultIconList;
  @protected
  List<Widget>? _tabSelectedIconList;
  @protected
  List<Widget>? _tabViewList;

  AppTabBaseBuilder setTabTitleList(List<String> tabTitleList);

  AppTabBaseBuilder setTabNumberList(List<String> tabNumberList);

  AppTabBaseBuilder setTabDefaultIconList(List<Widget> tabDefaultIconList);

  AppTabBaseBuilder setTabViewList(List<Widget> tabViewList);

  Widget build(BuildContext context);
}

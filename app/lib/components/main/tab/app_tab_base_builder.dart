import 'package:app/components/features/scroll_view/scroll_view_widget.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

part 'app_bottom_tab_builder.dart';
part 'app_tab_bar_widget.dart';

abstract class AppTabBaseBuilder {
  @protected
  List<PageRouteInfo<dynamic>>? _routes;

  @protected
  List<int>? _numbers;
  @protected
  List<String>? _labels;
  @protected
  List<Widget>? _icons;

  Widget build(BuildContext context);

  AppTabBaseBuilder setRoutes(List<PageRouteInfo<dynamic>>? routes);

  AppTabBaseBuilder setNumbers(List<int>? numbers);

  AppTabBaseBuilder setLabels(List<String>? labels);

  AppTabBaseBuilder setIcons(List<Widget>? icons);
}

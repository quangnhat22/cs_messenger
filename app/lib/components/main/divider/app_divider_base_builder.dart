import 'package:flutter/material.dart';

part 'app_divider_space_left_widget.dart';
part 'app_divider_text_widget.dart';

abstract class AppDividerBaseBuilder {
  @protected
  double? _width;

  AppDividerBaseBuilder setWidth(double? width);

  Widget build(BuildContext context);
}

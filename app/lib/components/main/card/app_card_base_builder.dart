import 'package:app/components/main/divider/app_divider_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

part 'app_card_border_widget.dart';
part 'app_card_widget.dart';

abstract class AppCardBaseBuilder {
  @protected
  Widget? _title;
  @protected
  Widget? _subtitle;
  @protected
  Widget? _leading;
  @protected
  List<Widget>? _actions;
  @protected
  void Function()? _onTap;
  @protected
  bool? _isDisabled;
  @protected
  Color? _backgroundColor;
  @protected
  bool? _isShowBottomDivider;

  Widget build(BuildContext context);

  AppCardBaseBuilder setTitle(Widget? title);

  AppCardBaseBuilder setSubtitle(Widget? subtitle);

  AppCardBaseBuilder setLeading(Widget? leading);

  AppCardBaseBuilder setActions(List<Widget>? actions);

  AppCardBaseBuilder setOnTap(void Function()? onTap);

  AppCardBaseBuilder setIsDisabled(bool? isDisabled);

  AppCardBaseBuilder setBackgroundColor(Color? backgroundColor);

  AppCardBaseBuilder setIsShowBottomDivider(bool? isShowBottomDivider);
}

import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

part 'app_snack_bar_widget.dart';

enum AppSnackBarStatus { info, error, warning, success }

enum AppSnackBarType { informMessage, toastMessage }

abstract class AppSnackBarBaseBuilder {
  @protected
  late final Widget? _content;
  @protected
  String? _labelText;
  @protected
  Widget? _prefixWidget;
  @protected
  Widget? _suffixWidget;
  @protected
  AppSnackBarStatus? _appSnackBarStatus;
  @protected
  AppSnackBarType? _appSnackBarType;
  @protected
  String? _buttonText;
  @protected
  EdgeInsets? _marginSnackBar;
  @protected
  void Function()? _onPress;

  @protected
  SnackBarBehavior? _behavior;

  AppSnackBarBaseBuilder setContent(Widget? content);

  AppSnackBarBaseBuilder setAppSnackBarStatus(
      AppSnackBarStatus? appSnackBarStatus);

  AppSnackBarBaseBuilder setAppSnackBarType(AppSnackBarType? appSnackBarType);

  AppSnackBarBaseBuilder setLabelText(String? labelText);

  AppSnackBarBaseBuilder setPrefixWidget(Widget? prefixWidget);

  AppSnackBarBaseBuilder setSuffixWidget(Widget? suffixWidget);

  AppSnackBarBaseBuilder setButtonText(String? buttonText);

  AppSnackBarBaseBuilder setOnPress(void Function()? onPress);

  AppSnackBarBaseBuilder setMarginSnackBar(EdgeInsets? marginSnackBar);

  AppSnackBarBaseBuilder setBehavior(SnackBarBehavior? behavior);

  void showSnackBar();
}

import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

part 'app_dialog_default_widget.dart';

enum AppDialogType {
  success(type: 'success'),
  error(type: 'error'),
  confirm(type: 'confirm');

  final String type;

  const AppDialogType({required this.type});
}

enum AppDialogButtonType {
  standard(type: 'standard'),
  danger(type: 'danger');

  final String type;

  const AppDialogButtonType({required this.type});
}

abstract class AppDialogBaseBuilder {
  @protected
  Dialog? _dialog;
  @protected
  String? _title;
  @protected
  String? _content;
  @protected
  Widget? _contentWidget;
  @protected
  String? _positiveText;
  @protected
  String? _negativeText;
  @protected
  Widget? _icon;
  @protected
  AppDialogType? _appDialogType;
  @protected
  void Function()? _onPositive;
  @protected
  void Function()? _onNegative;
  @protected
  Widget? _textField;
  @protected
  AppDialogButtonType? _appDialogButtonType;
  @protected
  bool? _isHaveCloseIcon;

  AppDialogBaseBuilder setContentWidget(Widget? contentWidget);

  AppDialogBaseBuilder setTextField(Widget? textField);

  AppDialogBaseBuilder setTitle(String? title);

  AppDialogBaseBuilder setContent(String? content);

  AppDialogBaseBuilder setPositiveText(String? positiveText);

  AppDialogBaseBuilder setNegativeText(String? negativeText);

  AppDialogBaseBuilder setIcon(Widget? icon);

  AppDialogBaseBuilder setAppDialogType(AppDialogType? type);

  AppDialogBaseBuilder setOnPositive(void Function()? onPositive);

  AppDialogBaseBuilder setOnNegative(void Function()? onNegative);

  AppDialogBaseBuilder setAppDialogButtonType(
      AppDialogButtonType? appDialogButtonType);

  AppDialogBaseBuilder setIsHaveCloseIcon(bool? isHaveCloseIcon);

  AppDialogBaseBuilder buildDialog(BuildContext context);

  void show() {
    final currentContent = AppKeys.navigatorKey.currentContext;
    if (_dialog == null && currentContent == null) return;
    // if (Get.isDialogOpen == true) return;
    // Get.dialog(_dialog!, barrierDismissible: false, useSafeArea: false);
    showDialog(
      context: currentContent!,
      builder: (context) => _dialog!,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
}

import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';

class AppLoadingOverlayWidget {
  static TransitionBuilder init() {
    return EasyLoading.init();
  }

  static void configure(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCube
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = AppSizeExt.of.majorScale(12)
      ..radius = AppSizeExt.of.majorScale(2)
      ..backgroundColor = AppColorPalette.of.grayColor[2]
      ..indicatorColor = Theme.of(context).colorScheme.primary
      ..progressColor = Theme.of(context).colorScheme.primary
      ..textColor = AppColorPalette.of.grayColor
      ..maskColor = AppColorPalette.of.grayColor[4]?.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show({String? message}) {
    EasyLoading.show(status: message);
  }

  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }
}

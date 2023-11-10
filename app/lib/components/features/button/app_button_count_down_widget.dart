import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class AppButtonCountDownWidget extends StatefulWidget {
  const AppButtonCountDownWidget(
      {super.key, this.onPressed, this.titleActive, this.titleNonActive});

  final VoidCallback? onPressed;
  final String? titleActive;
  final String? titleNonActive;

  @override
  State<AppButtonCountDownWidget> createState() =>
      _AppButtonCountDownWidgetState();
}

class _AppButtonCountDownWidgetState extends State<AppButtonCountDownWidget> {
  late CountdownTimerController controller;

  int endTime = DateTime.now().millisecondsSinceEpoch +
      1000 * AppConstants.timeDelaySendEmail;

  bool isAbleButton = false;

  @override
  void initState() {
    super.initState();
    animationStart();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void animationStart() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    setState(() {
      isAbleButton = true;
    });
  }

  void _onPressed() {
    widget.onPressed?.call();
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch +
          Duration(seconds: AppConstants.timeDelaySendEmail).inMilliseconds;
      isAbleButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      endTime: endTime,
      onEnd: onEnd, // send the function
      widgetBuilder: (_, time) {
        return AppButtonFilledWidget()
            .setButtonText(time == null
                ? widget.titleActive
                : "${widget.titleNonActive}: ${time.sec}")
            .setTextStyle(
                TextStyle(color: Theme.of(context).colorScheme.background))
            .setOnPressed(time == null ? _onPressed : null)
            .build(context);
      },
    );
  }
}

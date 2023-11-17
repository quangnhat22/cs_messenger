import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:resources/resources.dart';

class VerifyEmailWaitingWidget extends StatelessWidget {
  const VerifyEmailWaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SpinKitPouringHourGlassRefined(
          color: Theme.of(context).colorScheme.tertiary,
          size: AppSizeExt.of.majorScale(16),
        ),
        SizedBox(
          height: AppSizeExt.of.majorScale(1),
        ),
        AppTextBodyMediumWidget()
            .setText('${R.strings.verifying}...')
            .setColor(Theme.of(context).colorScheme.tertiary)
            .build(context),
      ],
    );
  }
}

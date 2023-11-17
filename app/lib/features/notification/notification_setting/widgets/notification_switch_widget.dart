import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class NotificationSwitchWidget extends StatelessWidget {
  const NotificationSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardBorderWidget()
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.notification)
            .build(context))
        .setContentPadding(
          EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(2 / 4),
            horizontal: AppSizeExt.of.majorPaddingScale(2),
          ),
        )
        .setActions(
      [
        Switch(
          value: true,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
          },
        )
      ],
    ).build(context);
  }
}

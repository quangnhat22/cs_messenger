import 'package:app/components/features/screens/app_notice_full_screen_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class SendEmailSuccessPage extends StatelessWidget {
  const SendEmailSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNoticeFullScreenWidget(
      title: R.strings.sendEmailSuccess,
      subTitle: R.strings.pleaseCheckYourEmailToRecovery,
      backgroundColor: AppColorPalette.of.greenColor,
      image: R.pngs.welldoneGreen.image(
        height: AppSizeExt.of.majorScale(80),
        width: AppSizeExt.of.majorScale(75),
      ),
      actions: [
        AppButtonFilledWidget()
            .setButtonText(R.strings.backToWelcome)
            .setTextStyle(TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.bold,
            ))
            .setOnPressed(() {})
            .build(context),
        const SizedBox(
          height: 8,
        ),
        AppButtonOutlineWidget()
            .setButtonText(R.strings.openEmailApp)
            .setOnPressed(() {})
            .build(context)
      ],
    );
  }
}

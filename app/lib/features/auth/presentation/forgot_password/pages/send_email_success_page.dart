import 'package:app/components/features/screens/app_notice_full_screen_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:resources/resources.dart';

@RoutePage()
class SendEmailSuccessPage extends StatelessWidget {
  final String? email;

  const SendEmailSuccessPage({super.key, this.email});

  void _handleButtonBackToWelcome() {
    getIt<AppRouter>().popUntilRoot();
  }

  void _handleButtonOpenMailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      _showNoMailAppsDialog();
    } else if (!result.didOpen && result.canOpen) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return MailAppPickerDialog(
              mailApps: result.options,
            );
          },
        );
      }
    }
  }

  void _showNoMailAppsDialog() async {
    AppDefaultDialogWidget()
        .setTitle(R.strings.openEmailApp)
        .setContent(R.strings.noMailAppInstalled)
        .setAppDialogType(AppDialogType.error)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .buildDialog(AppKeys.navigatorKey.currentContext!)
        .show();
  }

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
            .setOnPressed(() => _handleButtonBackToWelcome())
            .build(context),
        const SizedBox(
          height: 8,
        ),
        AppButtonOutlineWidget()
            .setButtonText(R.strings.openEmailApp)
            .setOnPressed(() => _handleButtonOpenMailApp(context))
            .build(context)
      ],
    );
  }
}

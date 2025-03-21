import 'package:app/components/features/button/app_button_count_down_widget.dart';
import 'package:app/components/features/screens/app_notice_full_screen_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/verify_email/controllers/bloc_verify_email/verify_email_cubit.dart';
import 'package:app/features/auth/presentation/verify_email/widgets/verify_email_waiting_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({
    super.key,
    this.isFirstRequestSendEmail = true,
  });

  final bool isFirstRequestSendEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<VerifyEmailCubit>()..initPage(isFirstRequestSendEmail),
      child: AppMainPageWidget()
          .setBackgroundColor(Theme.of(context).colorScheme.background)
          .setBody(_body(context))
          .build(context),
    );
  }

  void _handleOnLogOutButton(BuildContext context) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.logOut)
        .setContent(R.strings.doYouWantToLogOut)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await context.read<VerifyEmailCubit>().logOut();
        })
        .buildDialog(context)
        .show();
  }

  void _handleRequestResendEmail(BuildContext context) async {
    await context.read<VerifyEmailCubit>().requestSendVerifyEmail();
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

  Widget _body(BuildContext context) {
    return BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return AppNoticeFullScreenWidget(
          image: R.pngs.verifyEmail.image(),
          title: R.strings.verifyYourEmail,
          backgroundColor: Theme.of(context).colorScheme.primary,
          subTitle: R.strings.pleaseCheckYourEmail(
              state.email ?? '-',
              DateTimeExt.dateTimeToDisplayHHmmddMMyyyy(
                  dateTime: state.expireTime)),
          subWidget:
              state.isVerifying ? const VerifyEmailWaitingWidget() : null,
          actions: [
            AppButtonCountDownWidget(
              titleActive: R.strings.sendEmail,
              titleNonActive: R.strings.resendEmailAfter,
              onPressed: () => _handleRequestResendEmail(context),
            ),
            SizedBox(
              height: AppSizeExt.of.majorScale(1),
            ),
            AppButtonOutlineWidget()
                .setButtonText(R.strings.logOut)
                .setBorderColor(Theme.of(context).colorScheme.primary)
                .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.primary))
                .setOnPressed(() => _handleOnLogOutButton(context))
                .build(context),
            SizedBox(
              height: AppSizeExt.of.majorScale(1),
            ),
            AppButtonTextWidget()
                .setButtonText(R.strings.openEmailApp)
                .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.primary))
                .setOnPressed(() => _handleButtonOpenMailApp(context))
                .build(context)
          ],
        );
      },
    );
  }
}

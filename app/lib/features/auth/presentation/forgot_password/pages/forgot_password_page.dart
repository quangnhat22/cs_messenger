import 'package:app/components/features/scroll_view/scroll_view_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/forgot_password/controllers/forgot_password_form_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  void _handleOnPressSendEmailButton(BuildContext context) {
    context.read<ForgotPasswordFormBloc>().submit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordFormBloc>(),
      child: AppStackPageWidget()
          .setShowCircleBackgroundWidget(true)
          .setBackgroundColorCircle(
              Theme.of(context).colorScheme.tertiaryContainer)
          .setBackgroundColor(Theme.of(context).colorScheme.background)
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Builder(builder: (context) {
      return SafeArea(
        child: ScrollViewWidget(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
                    child: AppButtonFilledWidget()
                        .setAppButtonType(AppButtonType.circle)
                        .setPrefixIcon(Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).colorScheme.primary,
                        ))
                        .setBackgroundColor(
                            Theme.of(context).colorScheme.background)
                        .build(context),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizeExt.of.majorPaddingScale(5),
                    vertical: AppSizeExt.of.majorPaddingScale(4),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            R.pngs.welldoneGreen.image(
                              height: AppSizeExt.of.majorScale(80),
                              width: AppSizeExt.of.majorScale(75),
                            ),
                            SizedBox(
                              height: AppSizeExt.of.majorScale(6),
                            ),
                            AppTextDisplaySmallWidget()
                                .setText('${R.strings.forgotPassword}?')
                                .setColor(Theme.of(context).colorScheme.primary)
                                .setTextAlign(TextAlign.center)
                                .build(context),
                            SizedBox(
                              height: AppSizeExt.of.majorScale(6),
                            ),
                            AppTextBodyMediumWidget()
                                .setText(R.strings
                                    .registerEmailToReceivePasswordReset)
                                .setTextAlign(TextAlign.center)
                                .build(context),
                            SizedBox(
                              height: AppSizeExt.of.majorScale(6),
                            ),
                            Builder(builder: (ctx) {
                              return AppTextFieldWidget()
                                  .setBloc(
                                      ctx.read<ForgotPasswordFormBloc>().email)
                                  .setKeyboardType(TextInputType.emailAddress)
                                  .setAutoFillHints([AutofillHints.email])
                                  .setDecoration(
                                    InputDecoration(
                                      labelText: R.strings.email,
                                      prefixIcon:
                                          const Icon(Icons.email_outlined),
                                    ),
                                  )
                                  .build(context);
                            }),
                            SizedBox(
                              height: AppSizeExt.of.majorScale(6),
                            ),
                          ],
                        ),
                      ),
                      AppButtonFilledWidget()
                          .setButtonText(R.strings.sendEmail.toUpperCase())
                          .setTextStyle(
                            TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background),
                          )
                          .setOnPressed(
                              () => _handleOnPressSendEmailButton(context))
                          .build(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // child: SingleChildScrollView(
      );
    });
  }
}

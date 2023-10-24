import 'package:app/components/features/form/form_card_layout.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/login/controllers/login_form_bloc/login_form_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginFormBloc>(),
      child: AppMainPageWidget().setBody(_body(context)).build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Builder(
      builder: (context) {
        return FormCardLayout(
          title: R.strings.welcomeBack,
          subTitle: R.strings.signInYourAccountToSeeYourChatting,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.background,
          formWidget: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      AppTextFieldWidget()
                          .setBloc(context.read<LoginFormBloc>().email)
                          .setKeyboardType(TextInputType.emailAddress)
                          .setAutoFillHints([AutofillHints.email])
                          .setDecoration(
                            InputDecoration(
                              labelText: R.strings.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          )
                          .build(context),
                      SizedBox(
                        height: AppSizeExt.of.majorScale(4),
                      ),
                      AppTextFieldWidget()
                          .setBloc(context.read<LoginFormBloc>().email)
                          .setSuffixButton(SuffixButton.obscureText)
                          .setAutoFillHints([AutofillHints.password])
                          .setDecoration(
                            InputDecoration(
                              labelText: R.strings.password,
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                          )
                          .build(context),
                      SizedBox(
                        height: AppSizeExt.of.majorScale(4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          AppButtonTextWidget()
                              .setButtonText(R.strings.forgotPassword)
                              .setTextStyle(TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ))
                              .setOnPressed(() {})
                              .build(context),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              AppButtonFilledWidget()
                  .setButtonText(R.strings.login.toUpperCase())
                  .setTextStyle(TextStyle(
                      color: Theme.of(context).colorScheme.background))
                  .setAppButtonSize(AppButtonSize.large)
                  .setOnPressed(() {})
                  .build(context),
            ],
          ),
        );
      },
    );
  }
}

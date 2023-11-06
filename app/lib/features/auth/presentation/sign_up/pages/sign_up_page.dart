import 'package:app/components/features/form/form_card_layout.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/sign_up/controllers/sign_up_form_bloc/sign_up_form_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpFormBloc>(),
      child: AppMainPageWidget().setBody(_body(context)).build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Builder(
      builder: (context) {
        return FormCardLayout(
          title: R.strings.welcome,
          subTitle: R.strings.startChattingWithANewAccount,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          textColor: Theme.of(context).colorScheme.primary,
          formWidget: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      AppTextFieldWidget()
                          .setBloc(context.read<SignUpFormBloc>().email)
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
                          .setBloc(context.read<SignUpFormBloc>().password)
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
                      AppTextFieldWidget()
                          .setBloc(
                              context.read<SignUpFormBloc>().confirmPassword)
                          .setSuffixButton(SuffixButton.obscureText)
                          .setAutoFillHints([AutofillHints.password])
                          .setDecoration(
                            InputDecoration(
                              labelText: R.strings.confirmPassword,
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                          )
                          .build(context),
                    ],
                  ),
                ),
              ),
              AppButtonFilledWidget()
                  .setButtonText(R.strings.register.toUpperCase())
                  .setAppButtonSize(AppButtonSize.large)
                  .setBackgroundColor(
                      Theme.of(context).colorScheme.primaryContainer)
                  .setTextStyle(
                      TextStyle(color: Theme.of(context).colorScheme.primary))
                  .setOnPressed(() {})
                  .build(context),
            ],
          ),
        );
      },
    );
  }
}

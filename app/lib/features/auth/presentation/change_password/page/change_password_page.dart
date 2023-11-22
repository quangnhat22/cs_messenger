import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/change_password/controllers/change_password_form_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordFormBloc>(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.changePassword)
              .setBackgroundColor(Colors.transparent)
              .build(context))
          .setBackgroundColor(Theme.of(context).colorScheme.background)
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(5),
                  horizontal: AppSizeExt.of.majorPaddingScale(5),
                ),
                child: Column(
                  children: <Widget>[
                    AppTextFieldWidget()
                        .setBloc(context
                            .read<ChangePasswordFormBloc>()
                            .currentPassword)
                        .setSuffixButton(SuffixButton.obscureText)
                        .setAutoFillHints([AutofillHints.password])
                        .setLabelText(R.strings.currentPassword)
                        .build(context),
                    SizedBox(height: AppSizeExt.of.majorScale(2)),
                    AppTextFieldWidget()
                        .setBloc(
                            context.read<ChangePasswordFormBloc>().newPassword)
                        .setSuffixButton(SuffixButton.obscureText)
                        .setAutoFillHints([AutofillHints.password])
                        .setDecoration(
                          InputDecoration(
                            labelText: R.strings.newPassword,
                            contentPadding: EdgeInsets.all(
                              AppSizeExt.of.majorPaddingScale(4),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(AppSizeExt.of.majorScale(4)),
                            )),
                          ),
                        )
                        .build(context),
                    SizedBox(height: AppSizeExt.of.majorScale(2)),
                    AppTextFieldWidget()
                        .setBloc(context
                            .read<ChangePasswordFormBloc>()
                            .confirmNewPassword)
                        .setSuffixButton(SuffixButton.obscureText)
                        .setAutoFillHints([AutofillHints.password])
                        .setDecoration(
                          InputDecoration(
                            labelText: R.strings.confirmNewPassword,
                            contentPadding: EdgeInsets.all(
                              AppSizeExt.of.majorPaddingScale(4),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(AppSizeExt.of.majorScale(4)),
                            )),
                          ),
                        )
                        .build(context),
                    SizedBox(
                      height: AppSizeExt.of.majorScale(6),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            elevation: AppConstants.numberElevationContainer,
            child: Padding(
              padding: EdgeInsets.all(AppSizeExt.of.majorScale(4)),
              child: AppButtonFilledWidget()
                  .setButtonText(R.strings.update.toUpperCase())
                  .setAppButtonSize(AppButtonSize.large)
                  .setTextStyle(TextStyle(
                      color: Theme.of(context).colorScheme.background))
                  .setOnPressed(() => {})
                  .build(context),
            ),
          ),
        ],
      );
    });
  }
}

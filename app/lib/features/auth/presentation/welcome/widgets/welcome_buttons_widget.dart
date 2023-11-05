import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/divider/app_divider_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class WelcomeButtonsWidget extends StatelessWidget {
  const WelcomeButtonsWidget({super.key});

  void _handleSignInWithEmailBtn(BuildContext ctx) async {
    await ctx.router.push(const LoginRoute());
  }

  void _handleSignInWithGoogle(BuildContext ctx) async {
    // ctx.read<WelcomeBloc>().add(const WelcomeLoginWithGoogle());
    await ctx.router.push(const MainRoute());
  }

  void _handleSignUpWithEmailBtn(BuildContext ctx) async {
    await ctx.router.push(const SignUpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButtonOutlineWidget()
            .setButtonText(R.strings.signInWithEmail)
            .setPrefixIcon(
              Icon(
                Icons.email_outlined,
                size: AppSizeExt.of.majorScale(4),
              ),
            )
            .setBorderColor(Theme.of(context).colorScheme.primary)
            .setOnPressed(() => _handleSignInWithEmailBtn(context))
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(4),
        ),
        AppButtonOutlineWidget()
            .setButtonText(R.strings.signInWithGoogle)
            .setPrefixIcon(R.pngs.googleLogo.image(width: 16, height: 16))
            .setTextStyle(
                TextStyle(color: Theme.of(context).colorScheme.onSurface))
            .setOnPressed(() => _handleSignInWithGoogle(context))
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(5),
        ),
        AppDividerTextWidget().setText('Or').build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(4),
        ),
        AppButtonTextWidget()
            .setButtonText(R.strings.signUpWithEmail)
            .setTextStyle(
                TextStyle(color: Theme.of(context).colorScheme.primary))
            .setOnPressed(() => _handleSignUpWithEmailBtn(context))
            .build(context),
      ],
    );
  }
}

import 'package:app/components/features/scroll_view/scroll_view_widget.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/divider/app_divider_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _handleSignInWithEmailBtn(BuildContext ctx) async {
    await ctx.router.push(const LoginRoute());
  }

  void _handleSignInWithGoogle(BuildContext ctx) async {
    await ctx.router.push(const HomeRoute());
  }

  void _handleSignUpWithEmailBtn(BuildContext ctx) async {
    await ctx.router.push(const SignUpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return AppStackPageWidget()
        .setShowCircleBackgroundWidget(true)
        .setBackgroundColorCircle(
            Theme.of(context).colorScheme.tertiaryContainer)
        .setBackgroundColor(Theme.of(context).colorScheme.background)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: ScrollViewWidget(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(
              AppSizeExt.of.majorPaddingScale(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                R.pngs.welcomeBanner.image(
                  height: AppSizeExt.of.majorScale(250 / 4),
                ),
                SizedBox(
                  height: AppSizeExt.of.majorScale(4),
                ),
                AppTextHeadlineMediumWidget()
                    .setText('Get connect with your friend')
                    .setTextStyle(
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                    .build(context),
                SizedBox(
                  height: AppSizeExt.of.majorScale(8),
                ),
                AppButtonOutlineWidget()
                    .setButtonText('Sign in with email')
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
                    .setButtonText('Sign in with Google')
                    .setPrefixIcon(
                        R.pngs.googleLogo.image(width: 16, height: 16))
                    .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.onSurface))
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
                    .setButtonText('Sign up with your Email')
                    .setTextStyle(
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                    .setOnPressed(() => _handleSignUpWithEmailBtn(context))
                    .build(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

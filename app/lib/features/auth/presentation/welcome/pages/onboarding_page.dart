import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/slide/app_slide_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/welcome/controllers/onboarding/onboarding_cubit.dart';
import 'package:app/features/auth/presentation/welcome/widgets/onboarding_content_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: AppMainPageWidget()
          .setBackgroundColor(Theme.of(context).colorScheme.background)
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return AppSlideWidget()
            .setItems(<Widget>[
              OnboardingContentWidget(
                mainImage: R.pngs.onboardingFirstStep.image(),
                title: R.strings.welcomeToApp(AppConstants.appName),
                subtitle: R.strings.discoverSeamlessMessaging,
              ),
              OnboardingContentWidget(
                mainImage: R.pngs.onboardingSecondStep.image(),
                title: R.strings.connectingPeopleAnytimeAnywhere,
                subtitle: R.strings.experienceThePower,
              ),
              OnboardingContentWidget(
                mainImage: R.pngs.onboardingThirdStep.image(),
                title: R.strings.stayCloseNoMatterDistance,
                subtitle: R.strings.bridgeTheGap(AppConstants.appName),
              ),
            ])
            .setDurationNextPage(
              Duration(milliseconds: AppConstants.timeDurationSwitchPage),
            )
            .setScrollPhysics(const NeverScrollableScrollPhysics())
            .setIsShowDots(true)
            .setIndexInit(0)
            .setPadding(
              EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(4)),
            )
            .setTextNextButton(R.strings.next)
            .setTextBackButton(R.strings.back)
            .setTextSkipButton(R.strings.skip)
            .setOnFinish(() => _handleFinishOnboarding(context))
            .build(context);
      },
    );
  }

  void _handleFinishOnboarding(BuildContext context) async {
    context.read<OnboardingCubit>().updateValueFirstInstall();
    context.router.replace(const WelcomeRoute());
  }
}

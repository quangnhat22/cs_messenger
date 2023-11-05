import 'package:app/components/features/scroll_view/scroll_view_widget.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/auth/presentation/welcome/controllers/welcome/welcome_bloc.dart';
import 'package:app/features/auth/presentation/welcome/widgets/welcome_buttons_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WelcomeBloc>()..add(const WelcomeEvent.started()),
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
    return BlocConsumer<WelcomeBloc, WelcomeState>(
      listenWhen: (prev, current) =>
          prev.isFirstInstall != current.isFirstInstall ||
          prev.isAuthenticated != current.isAuthenticated,
      listener: (context, state) async {
        if (state.isFirstInstall) {
          await context.router.push(const OnboardingRoute());
        }
        if (state.isAuthenticated) {
          if (context.mounted) {
            await context.router.replace(const MainRoute());
          }
        }
      },
      builder: (context, state) {
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
                        .setText(R.strings.getConnectWithYourFriends)
                        .setTextAlign(TextAlign.center)
                        .setTextStyle(TextStyle(
                            color: Theme.of(context).colorScheme.primary))
                        .build(context),
                    SizedBox(
                      height: AppSizeExt.of.majorScale(8),
                    ),
                    (state.isLoading)
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: AppSizeExt.of.majorPaddingScale(10)),
                            child: const CircularProgressIndicator(),
                          )
                        : const WelcomeButtonsWidget()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

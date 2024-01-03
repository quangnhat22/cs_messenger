import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/setting/presentation/about_us/controllers/cubit/about_us_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AboutUsCubit>()..initPage(),
      child: AppMainPageWidget()
          .setAppBar(
              AppBarWidget().setTextTitle(R.strings.about).build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  void _openEmailContact(BuildContext ctx) async {
    try {
      await launchUrl(Uri.parse("mailto:${AppConstants.emailContact}"));
    } catch (e) {
      Logs.e(e);
      if (ctx.mounted) {
        AppSnackBarWidget()
            .setLabelText(R.strings.openEmailFail)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.error)
            .showSnackBarWithContext(ctx);
      }
    }
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<AboutUsCubit, AboutUsState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                R.pngs.appIcon.image(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                ),
                AppTextTitleLargeWidget().setText(state.appName).build(context),
                SizedBox(height: AppSizeExt.of.majorScale(2)),
                AppTextTitleMediumWidget()
                    .setText(state.appVersion)
                    .build(context),
                SizedBox(height: AppSizeExt.of.majorScale(2)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 4,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            height: 1.8,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: R.strings.contact_message,
                        ),
                        TextSpan(
                          text: state.emailContact,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _openEmailContact(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

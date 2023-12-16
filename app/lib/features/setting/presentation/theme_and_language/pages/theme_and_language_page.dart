import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/setting/presentation/theme_and_language/controllers/theme_and_language_cubit.dart';
import 'package:app/features/setting/presentation/theme_and_language/widgets/radio_list_tile_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class ThemeAndLanguagePage extends StatelessWidget {
  const ThemeAndLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeAndLanguageCubit>()..initPage(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.themeAndLanguage)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  void _handleThemeChanged(BuildContext context, String value) {
    context.read<ThemeAndLanguageCubit>().changeTheme(value);
  }

  void _handleLanguageChanged(BuildContext context, String value) {
    context.read<ThemeAndLanguageCubit>().changeLanguage(value);
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ThemeAndLanguageCubit, ThemeAndLanguageState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizeExt.of.majorPaddingScale(4),
                horizontal: AppSizeExt.of.majorPaddingScale(2),
              ),
              child: Column(
                children: [
                  //theme
                  Card(
                    elevation: 0,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3),
                    child: Padding(
                      padding:
                          EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppTextTitleLargeWidget()
                              .setText(R.strings.theme)
                              .setColor(Theme.of(context).colorScheme.primary)
                              .build(context),
                          SizedBox(
                            height: AppSizeExt.of.majorScale(3),
                          ),
                          RadioListTileWidget<String>(
                            groupValue: state.theme,
                            value: ThemeType.light.value,
                            label: R.strings.lightMode,
                            onChanged: (String value) =>
                                _handleThemeChanged(context, value),
                          ),
                          const Divider(),
                          RadioListTileWidget<String>(
                            groupValue: state.theme,
                            value: ThemeType.dark.value,
                            label: R.strings.darkMode,
                            onChanged: (String value) =>
                                _handleThemeChanged(context, value),
                          ),
                          const Divider(),
                          RadioListTileWidget<String>(
                            groupValue: state.theme,
                            value: ThemeType.system.value,
                            label: R.strings.system,
                            onChanged: (String value) =>
                                _handleThemeChanged(context, value),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(4),
                  ),
                  //language
                  Card(
                    elevation: 0,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3),
                    child: Padding(
                      padding:
                          EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppTextTitleLargeWidget()
                              .setText(R.strings.language)
                              .setColor(Theme.of(context).colorScheme.primary)
                              .build(context),
                          SizedBox(
                            height: AppSizeExt.of.majorScale(3),
                          ),
                          RadioListTileWidget<String>(
                            groupValue: state.language,
                            value: LanguageType.vi.value,
                            label: R.strings.vn,
                            onChanged: (String value) =>
                                _handleLanguageChanged(context, value),
                          ),
                          const Divider(),
                          RadioListTileWidget<String>(
                            groupValue: state.language,
                            value: LanguageType.en.value,
                            label: R.strings.en,
                            onChanged: (String value) =>
                                _handleLanguageChanged(context, value),
                          ),
                          const Divider(),
                          RadioListTileWidget<String>(
                            groupValue: state.language,
                            value: LanguageType.system.value,
                            label: R.strings.system,
                            onChanged: (String value) =>
                                _handleLanguageChanged(context, value),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/search/presentation/controllers/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resources/resources.dart';

import 'controllers/app_theme_language/app_theme_language_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppLoadingOverlayWidget.configure(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AppThemeLanguageCubit>()..initPage(),
        ),
        BlocProvider(
          create: (_) => getIt<SearchBloc>(),
        ),
      ],
      child: BlocBuilder<AppThemeLanguageCubit, AppThemeLanguageState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            supportedLocales: R.appLocalizationDelegate.supportedLocales,
            localizationsDelegates: const [
              R.appLocalizationDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: state.language,
            themeMode: state.theme,
            theme: AppThemeData.lightThemeData(context),
            darkTheme: AppThemeData.darkThemeData(context),
            routerConfig: getIt<AppRouter>().config(),
            builder: AppLoadingOverlayWidget.init(),
          );
        },
      ),
    );
  }
}

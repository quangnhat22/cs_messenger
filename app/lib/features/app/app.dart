import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resources/resources.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppLoadingOverlayWidget.configure(context);

    return MaterialApp.router(
      title: 'Flutter Demo',
      supportedLocales: R.appLocalizationDelegate.supportedLocales,
      localizationsDelegates: const [
        R.appLocalizationDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppThemeData.lightThemeData(context),
      darkTheme: AppThemeData.darkThemeData(context),
      routerConfig: getIt<AppRouter>().config(),
      builder: AppLoadingOverlayWidget.init(),
    );
  }
}

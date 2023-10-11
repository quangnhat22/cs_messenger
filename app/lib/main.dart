import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_constants_ext.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:configs/configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resources/resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Fsplash.preserve(widgetsBinding: WidgetsBinding.instance);
  configureAllPackagesDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Fsplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: R.appLocalizationDelegate.supportedLocales,
      localizationsDelegates: const [
        R.appLocalizationDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: AppKeys.navigatorKey,
      theme: AppThemeData.lightThemeData(),
      darkTheme: AppThemeData.darkThemeData(),
      home: const OnboardingPage(),
    );
  }
}

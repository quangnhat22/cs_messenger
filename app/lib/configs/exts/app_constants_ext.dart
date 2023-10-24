part of 'app_exts.dart';

class AppKeys {
  AppKeys._();

  static final navigatorKey = getIt<AppRouter>().navigatorKey;
}

class AppConstants {
  AppConstants._();

  static const appName = 'CS Messenger';

  static int timeDurationSwitchPage = 300;
}

part of 'app_exts.dart';

class AppKeys {
  AppKeys._();

  static final navigatorKey = getIt<AppRouter>().navigatorKey;
}

class AppConstants {
  AppConstants._();

  static const appName = 'CS Messenger';

  static int timeDurationSwitchPage = 300;

  static int timeDelaySendEmail = 30;
}

class AppFormKeys {
  AppFormKeys._();

  static const int durationDebounceTime = 300;

  static int maxLineErrorText = 4;
}

class AppLocalBoxKeys {
  AppLocalBoxKeys._();

  static const firstInstallAppBox = 'first_install_app_box';
}

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

  static int timeRepeatCallCheckVerifyEmail = 5000;

  static double numberElevationContainer = 10;

  static int timeDebounceSearch = 1000;

  static int sizeMbFileLimit = 10;
}

class AppFormKeys {
  AppFormKeys._();

  static const int durationDebounceTime = 300;

  static int maxLineErrorText = 4;
}

class AppLocalBoxKeys {
  AppLocalBoxKeys._();

  static const userBox = 'user_box';
  static const firstInstallAppBox = 'first_install_app_box';
  static const themeLanguageBox = 'theme_language_box';
  static const deviceInfoBox = 'device_info_box';
  static const notificationSettingBox = 'notification_setting_box';
}

class AppNavigationKeys {
  AppNavigationKeys._();

  static const timeSwitchPage = 300;
}

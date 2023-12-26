import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:utilities/utilities.dart';

@Singleton()
class OneSignalService {
  Future<void> init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(BuildConfig.onesignalKey);
    OneSignal.Notifications.requestPermission(true);
    OneSignal.User.pushSubscription.addObserver((stateChanges) {
      Logs.e(
          "SUBSCRIPTION STATE CHANGED: ${stateChanges.jsonRepresentation()}");
    });
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      Logs.d(event);

      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
    });
  }

  Future<void> turnOffReceivePushNotification() async {
    await OneSignal.User.pushSubscription.optOut();
  }

  Future<void> turnOnReceivePushNotification() async {
    await OneSignal.User.pushSubscription.optIn();
  }

  Future<void> login(String externalId) async {
    await OneSignal.login(externalId);
  }

  Future<void> logOut() async {
    try {
      await OneSignal.logout();
    } catch (e) {
      Logs.e(e);
    }
  }

  Future<void> setLanguage(String languageCode) async {
    await OneSignal.User.setLanguage(languageCode);
  }
}

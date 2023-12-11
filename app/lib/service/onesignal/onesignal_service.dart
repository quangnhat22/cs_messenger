import 'package:configs/configs.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

@Singleton()
class OneSignalService {
  Future<void> init() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(BuildConfig.onesignalKey);
    OneSignal.Notifications.requestPermission(true);
  }
}

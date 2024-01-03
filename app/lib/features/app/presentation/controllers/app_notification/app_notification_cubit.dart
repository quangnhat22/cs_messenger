import 'package:app/configs/exts/app_exts.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:utilities/utilities.dart';

part 'app_notification_cubit.freezed.dart';
part 'app_notification_state.dart';

@Injectable()
class AppNotificationCubit extends Cubit<AppNotificationState> {
  AppNotificationCubit() : super(const AppNotificationState.initial()) {
    onInit();
  }

  void onInit() async {
    try {
      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        emit(state.copyWith(isHasNewNotification: true));
      });
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  void removeNewNotificationStatus() {
    emit(state.copyWith(isHasNewNotification: false));
  }
}

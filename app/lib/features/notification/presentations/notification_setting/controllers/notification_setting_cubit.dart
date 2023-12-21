import 'package:app/service/onesignal/onesignal_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notification_setting_cubit.freezed.dart';
part 'notification_setting_state.dart';

@Injectable()
class NotificationSettingCubit extends Cubit<NotificationSettingState> {
  late final OneSignalService _notificationService;

  NotificationSettingCubit(this._notificationService)
      : super(const NotificationSettingState.initial());

  void onChangeNotificationStatus(bool value) async {
    if (value) {
      _notificationService.turnOnReceivePushNotification();
    } else {
      _notificationService.turnOffReceivePushNotification();
    }
    emit(state.copyWith(isTurnNotificationOn: value));
  }
}

part of 'notification_setting_cubit.dart';

@freezed
class NotificationSettingState with _$NotificationSettingState {
  const factory NotificationSettingState.initial({
    @Default(true) bool isTurnNotificationOn,
  }) = _Initial;
}

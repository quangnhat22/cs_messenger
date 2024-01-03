part of 'app_notification_cubit.dart';

@freezed
class AppNotificationState with _$AppNotificationState {
  const factory AppNotificationState.initial({
    @Default(false) bool isHasNewNotification,
  }) = _Initial;
}

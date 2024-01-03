part of 'base_raw.dart';

@freezed
class NotificationRaw extends BaseRaw<NotificationModel>
    with _$NotificationRaw {
  NotificationRaw._();

  factory NotificationRaw({
    required String id,
    required String heading,
    required String content,
    required NotificationDetailRaw details,
  }) = _NotificationRaw;

  factory NotificationRaw.fromJson(Map<String, Object?> json) =>
      _$NotificationRawFromJson(json);

  @override
  NotificationModel raw2Model() {
    return NotificationModel(
      id: id,
      heading: heading,
      content: content,
      details: details.raw2Model(),
    );
  }
}

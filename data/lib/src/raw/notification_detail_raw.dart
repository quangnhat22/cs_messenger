part of 'base_raw.dart';

@freezed
class NotificationDetailRaw extends BaseRaw<NotificationDetailModel>
    with _$NotificationDetailRaw {
  NotificationDetailRaw._();

  factory NotificationDetailRaw({
    NotificationObjectRaw? subject,
    NotificationObjectRaw? direct,
    NotificationObjectRaw? indirect,
    NotificationObjectRaw? prep,
    String? action,
    @JsonKey(name: 'created_at') int? createdAt,
  }) = _NotificationDetailRaw;

  factory NotificationDetailRaw.fromJson(Map<String, Object?> json) =>
      _$NotificationDetailRawFromJson(json);

  @override
  NotificationDetailModel raw2Model() {
    return NotificationDetailModel(
      subject: subject?.raw2Model(),
      direct: direct?.raw2Model(),
      indirect: indirect?.raw2Model(),
      prep: prep?.raw2Model(),
      action: action != null
          ? NotificationActionType.convertString2Enum(action!)
          : null,
      createdAt: createdAt != null
          ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
          : null,
    );
  }
}

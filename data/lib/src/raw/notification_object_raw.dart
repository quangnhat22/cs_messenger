part of 'base_raw.dart';

@freezed
class NotificationObjectRaw extends BaseRaw<NotificationObjectModel>
    with _$NotificationObjectRaw {
  NotificationObjectRaw._();

  factory NotificationObjectRaw({
    String? id,
    String? name,
    String? image,
    String? type,
  }) = _NotificationObjectRaw;

  factory NotificationObjectRaw.fromJson(Map<String, Object?> json) =>
      _$NotificationObjectRawFromJson(json);

  @override
  NotificationObjectModel raw2Model() {
    return NotificationObjectModel(
      id: id,
      name: name,
      image: image,
      type: type != null
          ? NotificationObjectType.convertString2Enum(type!)
          : null,
    );
  }
}

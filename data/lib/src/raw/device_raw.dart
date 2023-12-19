part of 'base_raw.dart';

@freezed
class DeviceRaw extends BaseRaw<DeviceModel> with _$DeviceRaw {
  DeviceRaw._();

  factory DeviceRaw({
    required String id,
    String? model,
    String? os,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'app_version') String? appVersion,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'last_active') int? lastActive,
  }) = _DeviceRaw;

  factory DeviceRaw.fromJson(Map<String, Object?> json) =>
      _$DeviceRawFromJson(json);

  @override
  DeviceModel raw2Model() {
    return DeviceModel(
      id: id,
      model: model,
      os: os,
      appVersion: appVersion,
      lastActive: lastActive != null
          ? DateTime.fromMillisecondsSinceEpoch(lastActive!)
          : null,
    );
  }
}

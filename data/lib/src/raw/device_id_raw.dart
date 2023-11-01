part of 'base_raw.dart';

@freezed
class DeviceIdRaw extends BaseRaw<DeviceIdModel> with _$DeviceIdRaw {
  DeviceIdRaw._();

  factory DeviceIdRaw({
    required String id,
  }) = _DeviceIdRaw;

  factory DeviceIdRaw.fromJson(Map<String, Object?> json) =>
      _$DeviceIdRawFromJson(json);

  @override
  DeviceIdModel raw2Model() {
    return DeviceIdModel(
      id: id,
    );
  }
}

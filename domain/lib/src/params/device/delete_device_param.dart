part of '../base_param.dart';

@freezed
class DeleteDeviceParam extends BaseParam with _$DeleteDeviceParam {
  const factory DeleteDeviceParam({required String deviceId}) =
      _DeleteDeviceParam;

  factory DeleteDeviceParam.fromJson(Map<String, Object?> json) =>
      _$DeleteDeviceParamFromJson(json);
}

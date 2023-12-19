part of '../base_param.dart';

@freezed
class GetListDeviceParam extends BaseParam with _$GetListDeviceParam {
  const factory GetListDeviceParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListDeviceParam;

  factory GetListDeviceParam.fromJson(Map<String, Object?> json) =>
      _$GetListDeviceParamFromJson(json);
}

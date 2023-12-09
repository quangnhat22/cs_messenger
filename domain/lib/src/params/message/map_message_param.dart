part of '../base_param.dart';

@freezed
class MapMessageParam extends IMessageParam with _$MapMessageParam {
  const factory MapMessageParam({
    required double lat,
    required double long,
    String? name,
  }) = _MapMessageParam;

  factory MapMessageParam.fromJson(Map<String, Object?> json) =>
      _$MapMessageParamFromJson(json);
}

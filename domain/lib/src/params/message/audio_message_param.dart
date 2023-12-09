part of '../base_param.dart';

@freezed
class AudioMessageParam extends IMessageParam with _$AudioMessageParam {
  const factory AudioMessageParam({
    String? name,
    required String uri,
  }) = _AudioMessageParam;

  factory AudioMessageParam.fromJson(Map<String, Object?> json) =>
      _$AudioMessageParamFromJson(json);
}

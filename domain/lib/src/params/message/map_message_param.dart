part of '../base_param.dart';

@freezed
class MapMessageParam extends IMessageParam with _$MapMessageParam {
  const factory MapMessageParam({
    String? clientId,
    required double lat,
    required double long,
    String? name,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
  }) = _MapMessageParam;

  factory MapMessageParam.fromJson(Map<String, Object?> json) =>
      _$MapMessageParamFromJson(json);
}

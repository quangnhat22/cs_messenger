part of '../base_param.dart';

@freezed
class AudioMessageParam extends IMessageParam with _$AudioMessageParam {
  const factory AudioMessageParam({
    String? name,
    required String uri,
    String? clientId,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
  }) = _AudioMessageParam;

  factory AudioMessageParam.fromJson(Map<String, Object?> json) =>
      _$AudioMessageParamFromJson(json);
}

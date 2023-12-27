part of '../base_param.dart';

@freezed
class VideoMessageParam extends IMessageParam with _$VideoMessageParam {
  const factory VideoMessageParam({
    String? name,
    String? clientId,
    String? thumbnailUrl,
    required String uri,
    @Default(0) double size,
    double? duration,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
  }) = _VideoMessageParam;

  factory VideoMessageParam.fromJson(Map<String, Object?> json) =>
      _$VideoMessageParamFromJson(json);
}

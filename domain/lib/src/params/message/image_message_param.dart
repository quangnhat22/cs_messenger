part of '../base_param.dart';

@freezed
class ImageMessageParam extends IMessageParam with _$ImageMessageParam {
  const factory ImageMessageParam({
    String? name,
    required String uri,
    String? clientId,
    double? size,
    double? height,
    double? width,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
    @Default(false) bool isForward,
  }) = _ImageMessageParam;

  factory ImageMessageParam.fromJson(Map<String, Object?> json) =>
      _$ImageMessageParamFromJson(json);
}

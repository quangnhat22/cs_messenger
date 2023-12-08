part of '../base_param.dart';

@freezed
class ImageMessageParam extends BaseParam with _$ImageMessageParam {
  const factory ImageMessageParam({
    String? name,
    required String uri,
    double? size,
    double? height,
    double? width,
  }) = _ImageMessageParam;

  factory ImageMessageParam.fromJson(Map<String, Object?> json) =>
      _$ImageMessageParamFromJson(json);
}

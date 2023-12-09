part of '../base_param.dart';

@freezed
class PreviewDataParam extends IMessageParam with _$PreviewDataParam {
  const factory PreviewDataParam({
    String? title,
    String? description,
    String? image,
    String? link,
  }) = _PreviewDataParam;

  factory PreviewDataParam.fromJson(Map<String, Object?> json) =>
      _$PreviewDataParamFromJson(json);
}

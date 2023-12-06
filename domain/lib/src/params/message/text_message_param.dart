part of '../base_param.dart';

@freezed
class TextMessageParam extends BaseParam with _$TextMessageParam {
  const factory TextMessageParam({
    Map<String, dynamic>? metadata,
    PreviewDataParam? previewData,
    required String text,
  }) = _TextMessageParam;

  factory TextMessageParam.fromJson(Map<String, Object?> json) =>
      _$TextMessageParamFromJson(json);
}

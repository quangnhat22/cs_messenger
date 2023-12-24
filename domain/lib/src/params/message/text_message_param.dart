part of '../base_param.dart';

@freezed
class TextMessageParam extends IMessageParam with _$TextMessageParam {
  const factory TextMessageParam({
    @Default('-1') String roomId,
    String? clientId,
    required String text,
    PreviewDataParam? previewData,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
  }) = _TextMessageParam;

  factory TextMessageParam.fromJson(Map<String, Object?> json) =>
      _$TextMessageParamFromJson(json);
}

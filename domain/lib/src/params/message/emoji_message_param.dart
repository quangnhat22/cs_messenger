part of '../base_param.dart';

@freezed
class EmojiMessageParam extends IMessageParam with _$EmojiMessageParam {
  const factory EmojiMessageParam({
    required String link,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
  }) = _EmojiMessageParam;

  factory EmojiMessageParam.fromJson(Map<String, Object?> json) =>
      _$EmojiMessageParamFromJson(json);
}

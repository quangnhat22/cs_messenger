part of '../base_param.dart';

@freezed
class EmojiMessageParam extends IMessageParam with _$EmojiMessageParam {
  const factory EmojiMessageParam({
    required String link,
    @JsonKey(includeFromJson: false) ReplyMessageParam? repliedMessage,
    @Default(false) bool isForward,
  }) = _EmojiMessageParam;

  factory EmojiMessageParam.fromJson(Map<String, Object?> json) =>
      _$EmojiMessageParamFromJson(json);
}

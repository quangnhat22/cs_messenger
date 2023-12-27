part of '../base_param.dart';

@freezed
class ReplyMessageParam extends IMessageParam with _$ReplyMessageParam {
  const factory ReplyMessageParam({
    required String id,
    String? authorName,
    String? roomId,
    String? clientId,
    String? content,
    String? type,
  }) = _ReplyMessageParam;

  factory ReplyMessageParam.fromJson(Map<String, Object?> json) =>
      _$ReplyMessageParamFromJson(json);

  static ReplyMessageParam convert2ReplyMessageParam(IMessageModel model) {
    return ReplyMessageParam(
      id: model.id,
      roomId: model.roomId,
      clientId: model.clientId,
      content: model.content,
      type: model.type.value,
      authorName: model.author.name,
    );
  }

  static ReplyMessageModel convertReplyParam2Model(ReplyMessageParam params) {
    return ReplyMessageModel(
      id: params.id,
      authorName: params.authorName,
      roomId: params.roomId,
      clientId: params.clientId,
      content: params.content,
      type: MessageType.convertString2MessageType(params.type),
    );
  }
}

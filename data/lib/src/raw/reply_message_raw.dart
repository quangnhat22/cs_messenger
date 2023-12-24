part of 'base_raw.dart';

@freezed
class ReplyMessageRaw extends BaseRaw<ReplyMessageModel>
    with _$ReplyMessageRaw {
  ReplyMessageRaw._();

  factory ReplyMessageRaw({
    required String id,
    String? authorName,
    String? roomId,
    String? clientId,
    String? content,
    String? type,
  }) = _ReplyMessageRaw;

  factory ReplyMessageRaw.fromJson(Map<String, Object?> json) =>
      _$ReplyMessageRawFromJson(json);

  @override
  ReplyMessageModel raw2Model() {
    return ReplyMessageModel(
      id: id,
      authorName: authorName,
      roomId: roomId,
      clientId: clientId,
      content: content,
      type: MessageType.convertString2MessageType(type),
    );
  }
}

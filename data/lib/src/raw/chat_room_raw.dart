part of 'base_raw.dart';

@freezed
class ChatRoomRaw extends BaseRaw<ChatRoomModel> with _$ChatRoomRaw {
  ChatRoomRaw._();

  factory ChatRoomRaw({
    required String id,
    String? name,
    String? avatar,
    MessageRaw? message,
    required String roomId,
    String? extra,
  }) = _ChatRoomRaw;

  factory ChatRoomRaw.fromJson(Map<String, Object?> json) =>
      _$ChatRoomRawFromJson(json);

  @override
  ChatRoomModel raw2Model() {
    return ChatRoomModel(
      id: id,
      name: name,
      avatar: avatar,
      message: message?.raw2Model(),
    );
  }
}

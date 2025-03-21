part of 'base_raw.dart';

@freezed
class ChatRoomRaw extends BaseRaw<ChatRoomModel> with _$ChatRoomRaw {
  ChatRoomRaw._();

  factory ChatRoomRaw({
    required String id,
    String? name,
    String? avatar,
    MessageRaw? message,
    //ignore: invalid_annotation_target
    @JsonKey(name: 'is_calling') bool? isCalling,
    String? extra,
    String? type,
    //ignore: invalid_annotation_target
    @JsonKey(name: 'group_id') String? groupId,
    //ignore: invalid_annotation_target
    @JsonKey(name: 'friend_id') String? friendId,
    //ignore: invalid_annotation_target
    @JsonKey(name: 'is_latest_message') bool? isLatestMessage,
    //ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false) String? offset,
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
      type: ChatRoomType.convert2ChatRoomType(type),
      groupId: groupId,
      isCalling: isCalling,
      friendId: friendId,
      isLatestMessage: message?.isLatestMessage,
      offset: message?.offset,
    );
  }
}

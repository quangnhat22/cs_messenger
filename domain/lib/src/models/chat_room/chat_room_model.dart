part of '../base_model.dart';

enum ChatRoomType {
  group('group'),
  p2p('p2p');

  const ChatRoomType(this.value);

  final String value;

  static ChatRoomType convert2ChatRoomType(String? value) {
    if (value == ChatRoomType.group.value) {
      return ChatRoomType.group;
    } else if (value == ChatRoomType.p2p.value) {
      return ChatRoomType.p2p;
    } else {
      throw UnsupportedError('chatRoomType not supported');
    }
  }
}

@freezed
class ChatRoomModel extends BaseModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String id,
    String? name,
    String? avatar,
    IMessageModel? message,
    bool? isCalling,
    @Default(false) bool isHasNewMessage,
    ChatRoomType? type,
    String? groupId,
  }) = _ChatRoomModel;

  static ChatRoomModel get empty => const ChatRoomModel(id: '-1');
}

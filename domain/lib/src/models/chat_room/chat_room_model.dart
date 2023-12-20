part of '../base_model.dart';

@freezed
class ChatRoomModel extends BaseModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String id,
    String? name,
    String? avatar,
    IMessageModel? message,
    bool? isCalling,
    @Default(false) bool isHasNewMessage,
  }) = _ChatRoomModel;

  static ChatRoomModel get empty => ChatRoomModel(id: '-1');
}

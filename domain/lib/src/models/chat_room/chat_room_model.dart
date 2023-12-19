part of '../base_model.dart';

class ChatRoomModel extends BaseModel {
  final String id;
  final String? name;
  final String? avatar;
  final IMessageModel? message;
  final bool? isCalling;

  ChatRoomModel({
    required this.id,
    this.name,
    this.avatar,
    this.message,
    this.isCalling,
  });

  static ChatRoomModel get empty => ChatRoomModel(id: '-1');
}

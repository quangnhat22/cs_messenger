part of '../base_model.dart';

class EmojiStickerModel extends IMessageModel {
  final String? link;

  EmojiStickerModel({
    required super.id,
    super.clientId,
    required super.author,
    required super.content,
    required super.type,
    required super.isMe,
    super.status,
    required super.roomId,
    super.createdAt,
    super.deletedAt,
    this.link,
  });
}

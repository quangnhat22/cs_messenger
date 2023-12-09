part of '../base_model.dart';

class EmojiStickerModel extends IMessageModel {
  final String content;

  EmojiStickerModel({
    required this.content,
    required super.id,
    required super.author,
  });
}

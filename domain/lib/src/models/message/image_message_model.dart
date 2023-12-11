part of '../base_model.dart';

class ImageMessageModel extends IMessageModel {
  final String? name;
  final String uri;
  final double? size;
  final double? width;
  final double? height;

  ImageMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    required super.content,
    required super.type,
    super.isMe,
    super.status,
    required super.roomId,
    super.createdAt,
    super.deletedAt,
    this.name,
    required this.uri,
    this.size,
    this.width,
    this.height,
  });
}

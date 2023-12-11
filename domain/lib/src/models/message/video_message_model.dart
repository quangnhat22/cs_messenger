part of '../base_model.dart';

class VideoMessageModel extends IMessageModel {
  final double size;
  final String uri;
  final String? thumbnailUrl;
  final String? name;

  VideoMessageModel({
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
    required this.size,
    required this.uri,
    this.name,
    this.thumbnailUrl,
  });
}

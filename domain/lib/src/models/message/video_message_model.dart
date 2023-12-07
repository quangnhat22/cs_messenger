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
    super.createdAt,
    super.repliedMessage,
    super.roomId,
    super.status,
    super.type,
    super.metadata,
    required this.size,
    required this.uri,
    this.name,
    this.thumbnailUrl,
  });
}

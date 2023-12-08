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
    super.createdAt,
    super.repliedMessage,
    super.roomId,
    super.status,
    super.type,
    super.metadata,
    this.name,
    required this.uri,
    this.size,
    this.width,
    this.height,
  });
}

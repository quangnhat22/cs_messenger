part of '../base_model.dart';

class FileMessageModel extends IMessageModel {
  final String? mimeType;
  final double size;
  final String uri;
  final String? name;
  final bool? isLoading;

  FileMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    super.createdAt,
    super.repliedMessage,
    super.roomId,
    super.status,
    super.type,
    super.metadata,
    this.isLoading = false,
    this.mimeType,
    required this.size,
    required this.uri,
    this.name,
  });
}

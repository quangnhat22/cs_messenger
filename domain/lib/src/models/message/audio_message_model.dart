part of '../base_model.dart';

class AudioMessageModel extends IMessageModel {
  final String? name;
  final String uri;

  AudioMessageModel({
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
  });
}

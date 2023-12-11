part of '../base_model.dart';

class AudioMessageModel extends IMessageModel {
  final String? name;
  final String uri;

  AudioMessageModel({
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
  });
}

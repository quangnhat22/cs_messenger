part of '../base_model.dart';

class AudioMessageModel extends IMessageModel {
  final int duration;
  final String? mimeType;
  final String? name;
  final String uri;
  final List<double>? waveForm;
  final double? size;

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
    required this.duration,
    this.mimeType,
    this.name,
    required this.uri,
    this.waveForm,
    this.size,
  });
}

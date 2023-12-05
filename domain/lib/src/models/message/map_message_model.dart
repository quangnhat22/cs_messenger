part of '../base_model.dart';

class MapMessageModel extends IMessageModel {
  final double lat;
  final double long;
  final String? name;

  MapMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    super.createdAt,
    super.repliedMessage,
    super.roomId,
    super.status,
    super.type,
    super.metadata,
    required this.lat,
    required this.long,
    this.name,
  });
}

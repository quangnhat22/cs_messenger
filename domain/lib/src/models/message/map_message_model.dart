part of '../base_model.dart';

class MapMessageModel extends IMessageModel {
  final double lat;
  final double long;
  final String? name;

  MapMessageModel({
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
    required this.lat,
    required this.long,
    this.name,
    super.isShowStatus,
  });
}

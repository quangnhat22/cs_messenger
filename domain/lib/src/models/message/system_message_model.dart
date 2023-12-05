part of '../base_model.dart';

class SystemMessageModel extends IMessageModel {
  final String text;

  SystemMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    super.createdAt,
    super.repliedMessage,
    super.roomId,
    super.status,
    super.type,
    super.metadata,
    required this.text,
  });
}

part of '../base_model.dart';

class SystemMessageModel extends IMessageModel {
  SystemMessageModel({
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
  });
}

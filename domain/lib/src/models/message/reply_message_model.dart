part of '../base_model.dart';

class ReplyMessageModel extends BaseModel {
  final String id;
  final String? authorName;
  final String? roomId;
  final String? clientId;
  final String? content;
  final MessageType? type;

  ReplyMessageModel({
    required this.id,
    this.authorName,
    this.roomId,
    this.clientId,
    this.content,
    this.type,
  });
}

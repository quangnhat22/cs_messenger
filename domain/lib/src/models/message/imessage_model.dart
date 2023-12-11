part of '../base_model.dart';

enum StatusMessageType {
  error(value: 'error'),
  sending(value: 'sending'),
  sent(value: 'sent');

  const StatusMessageType({required this.value});

  final String value;

  static StatusMessageType convertString2StatusMessageType(String? type) {
    if (StatusMessageType.sending.value == type) {
      return StatusMessageType.sending;
    } else if (StatusMessageType.sent.value == type) {
      return StatusMessageType.sent;
    } else {
      return StatusMessageType.error;
    }
  }
}

enum MessageType {
  text(value: "text"),
  system(value: "system"),
  image(value: "image"),
  audio(value: "audio"),
  video(value: "video"),
  file(value: "file"),
  map(value: "map"),
  emoji(value: "emoji"),
  custom(value: "custom");

  const MessageType({required this.value});

  final String value;

  static MessageType convertString2MessageType(String? type) {
    if (MessageType.text.value == type) {
      return MessageType.text;
    } else if (MessageType.system.value == type) {
      return MessageType.system;
    } else if (MessageType.image.value == type) {
      return MessageType.image;
    } else if (MessageType.audio.value == type) {
      return MessageType.audio;
    } else if (MessageType.video.value == type) {
      return MessageType.video;
    } else if (MessageType.file.value == type) {
      return MessageType.file;
    } else if (MessageType.map.value == type) {
      return MessageType.map;
    } else if (MessageType.emoji.value == type) {
      return MessageType.emoji;
    } else {
      return MessageType.custom;
    }
  }
}

abstract class IMessageModel extends BaseModel {
  // final String id;
  // final String? clientId;
  // final UserModel author;
  // final DateTime? createdAt;
  // final IMessageModel? repliedMessage;
  // final String? roomId;
  // final StatusMessageType? status;
  // final MessageType? type;
  // final Map<String, dynamic>? metadata;
  // final bool showStatus;
  final String id;
  final String? clientId;
  final UserModel author;
  final String content;
  final MessageType type;
  final bool isMe;
  final StatusMessageType? status;
  final String roomId;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  IMessageModel({
    required this.id,
    this.clientId,
    required this.author,
    required this.content,
    this.isMe = false,
    this.createdAt,
    this.deletedAt,
    required this.roomId,
    this.status,
    required this.type,
  });
}

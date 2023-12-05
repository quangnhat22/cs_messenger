part of '../base_model.dart';

class TextMessageModel extends IMessageModel {
  final String text;
  final PreviewDataModel? previewData;

  TextMessageModel({
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
    this.previewData,
  });
}

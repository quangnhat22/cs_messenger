part of '../base_model.dart';

class TextMessageModel extends IMessageModel {
  final PreviewDataModel? previewData;
  final IMessageModel? repliedMessage;

  TextMessageModel({
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
    this.previewData,
    this.repliedMessage,
  });

  static TextMessageModel getTextMessageModelFromParam(
      TextMessageParam param, UserModel currentUser) {
    return TextMessageModel(
      id: DateTime.now().toString(),
      clientId: param.clientId,
      author: currentUser,
      content: param.text,
      type: MessageType.text,
      isMe: true,
      status: StatusMessageType.sending,
      roomId: param.roomId,
      createdAt: DateTime.now(),
      // repliedMessage: param.repliedMessage,
      // previewData:  param.previewData,
    );
  }
}

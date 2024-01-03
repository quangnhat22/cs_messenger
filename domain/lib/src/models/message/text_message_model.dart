part of '../base_model.dart';

@freezed
class TextMessageModel extends IMessageModel with _$TextMessageModel {
  const factory TextMessageModel({
    required String id,
    String? clientId,
    required UserModel author,
    required String content,
    required MessageType type,
    @Default(false) bool isMe,
    StatusMessageType? status,
    required String roomId,
    DateTime? createdAt,
    DateTime? deletedAt,
    PreviewDataModel? previewData,
    ReplyMessageModel? repliedMessage,
    @Default(false) bool isShowStatus,
    @Default(false) bool isForward,
  }) = _TextMessageModel;

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
      isShowStatus: true,
      // repliedMessage: param.repliedMessage,
      // previewData:  param.previewData,
    );
  }
}

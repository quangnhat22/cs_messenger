part of '../base_model.dart';

@freezed
class FileMessageModel extends IMessageModel with _$FileMessageModel {
  // final String? mimeType;
  // final double size;
  // final String uri;
  // final String? name;
  // final bool? isLoading;

  const factory FileMessageModel({
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
    @Default(false) bool isLoading,
    String? mimeType,
    required double size,
    required String uri,
    String? name,
    @Default(true) bool isShowStatus,
    ReplyMessageModel? repliedMessage,
  }) = _FileMessageModel;

  static FileMessageModel getFileMessageModelFromParam(
      FileMessageParam param, UserModel currentUser, String chatRoomId) {
    return FileMessageModel(
      id: param.clientId ?? DateTime.now().toString(),
      clientId: param.clientId,
      author: currentUser,
      content: param.uri,
      type: MessageType.file,
      isMe: true,
      status: StatusMessageType.sending,
      roomId: chatRoomId,
      createdAt: DateTime.now(),
      isShowStatus: true,
      isLoading: true,
      mimeType: param.mimeType,
      size: param.size,
      uri: param.uri,
      name: param.name,
      repliedMessage: param.repliedMessage != null
          ? ReplyMessageParam.convertReplyParam2Model(param.repliedMessage!)
          : null,
    );
  }
}

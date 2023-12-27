part of '../base_model.dart';

class ImageMessageModel extends IMessageModel {
  final String? name;
  final String uri;
  final double? size;
  final double? width;
  final double? height;

  ImageMessageModel({
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
    this.name,
    required this.uri,
    this.size,
    this.width,
    this.height,
    super.isShowStatus,
    super.repliedMessage,
  });

  static ImageMessageModel getImageMessageModelFromParam(
      ImageMessageParam param, UserModel currentUser, String chatRoomId) {
    return ImageMessageModel(
      id: param.clientId ?? DateTime.now().toString(),
      clientId: param.clientId,
      author: currentUser,
      content: param.uri,
      type: MessageType.image,
      isMe: true,
      status: StatusMessageType.sending,
      roomId: chatRoomId,
      createdAt: DateTime.now(),
      isShowStatus: true,
      size: param.size,
      uri: param.uri,
      name: param.name,
      repliedMessage: param.repliedMessage != null
          ? ReplyMessageParam.convertReplyParam2Model(param.repliedMessage!)
          : null,
    );
  }
}

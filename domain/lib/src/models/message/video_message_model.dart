part of '../base_model.dart';

class VideoMessageModel extends IMessageModel {
  final double size;
  final String uri;
  final String? thumbnailUrl;
  final String? name;

  VideoMessageModel({
    required super.id,
    super.clientId,
    required super.author,
    required super.content,
    required super.type,
    required super.isMe,
    super.status,
    required super.roomId,
    super.createdAt,
    super.deletedAt,
    required this.size,
    required this.uri,
    this.name,
    this.thumbnailUrl,
    super.isShowStatus,
    super.repliedMessage,
  });

  static VideoMessageModel getVideoMessageModelFromParam(
      VideoMessageParam param, UserModel currentUser, String chatRoomId) {
    return VideoMessageModel(
      id: param.clientId ?? DateTime.now().toString(),
      clientId: param.clientId,
      author: currentUser,
      content: param.uri,
      type: MessageType.video,
      isMe: true,
      status: StatusMessageType.sending,
      roomId: chatRoomId,
      createdAt: DateTime.now(),
      isShowStatus: true,
      thumbnailUrl: param.thumbnailUrl,
      size: param.size,
      uri: param.uri,
      name: param.name,
    );
  }
}

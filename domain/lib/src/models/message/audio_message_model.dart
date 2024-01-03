part of '../base_model.dart';

class AudioMessageModel extends IMessageModel {
  final String? name;
  final String uri;

  AudioMessageModel({
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
    super.isShowStatus,
    super.repliedMessage,
    super.isForward = false,
  });

  static AudioMessageModel getAudioMessageModelFromParam(
      AudioMessageParam param, UserModel currentUser, String chatRoomId) {
    return AudioMessageModel(
      id: param.clientId ?? DateTime.now().toString(),
      clientId: param.clientId,
      author: currentUser,
      content: param.uri,
      type: MessageType.audio,
      isMe: true,
      status: StatusMessageType.sending,
      roomId: chatRoomId,
      createdAt: DateTime.now(),
      isShowStatus: true,
      uri: param.uri,
      name: param.name,
      repliedMessage: param.repliedMessage != null
          ? ReplyMessageParam.convertReplyParam2Model(param.repliedMessage!)
          : null,
    );
  }
}

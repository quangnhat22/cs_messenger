part of 'base_raw.dart';

@freezed
class MessageRaw extends BaseRaw<IMessageModel> with _$MessageRaw {
  MessageRaw._();

  factory MessageRaw({
    required String id,
    UserRaw? author,
    required String content,
    required String type,
    @Default(false) bool isMe,
    @Default('sent') String? status,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'room_id') required String roomId,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at') int? createdAt,
    int? deletedAt,
    String? extra,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'is_latest_message') @Default(false) bool isLatestMessage,
    String? offset,
  }) = _MessageRaw;

  factory MessageRaw.fromJson(Map<String, Object?> json) =>
      _$MessageRawFromJson(json);

  @override
  IMessageModel raw2Model() {
    final extraMessage =
        extra != null && extra!.isNotEmpty ? jsonDecode(extra!) : null;
    switch (type) {
      case "text":
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }

        return TextMessageModel(
          id: id,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          content: content,
          type: MessageType.text,
          isMe: isMe,
          status: StatusMessageType.convertString2StatusMessageType(status),
          roomId: roomId,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          deletedAt: deletedAt != null
              ? DateTimeExt.convertTimeStampToDateTime(deletedAt!)
              : null,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
          // clientId: clientId,
        );
      case "map":
        final name = extraMessage?['name'] as String?;
        final lat = extraMessage?['lat'] as double?;
        final long = extraMessage?['long'] as double?;
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return MapMessageModel(
          id: id,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          content: content,
          type: MessageType.map,
          isMe: isMe,
          status: StatusMessageType.convertString2StatusMessageType(status),
          roomId: roomId,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          deletedAt: deletedAt != null
              ? DateTimeExt.convertTimeStampToDateTime(deletedAt!)
              : null,
          // clientId: clientId,
          name: name,
          lat: lat ?? 10.782637,
          long: long ?? 106.695944,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      case "gif":
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final link = extraMessage?['link'] as String?;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return EmojiStickerModel(
          id: id,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          content: content,
          type: MessageType.emoji,
          isMe: isMe,
          status: StatusMessageType.convertString2StatusMessageType(status),
          roomId: roomId,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          deletedAt: deletedAt != null
              ? DateTimeExt.convertTimeStampToDateTime(deletedAt!)
              : null,
          // clientId: clientId,
          link: link,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      case "system":
        return SystemMessageModel(
          id: id,
          // clientId: clientId,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          roomId: roomId,
          status: StatusMessageType.convertString2StatusMessageType(status),
          type: MessageType.convertString2MessageType(type),
          content: SystemMessageModel.convertSystemMessage2String(content),
          isMe: isMe,
          systemMessage: SystemContent.convertSystemMessage2Enum(content),
        );
      case "image":
        final size = extraMessage?['size'] as double?;
        final height = extraMessage?['height'] as double?;
        final width = extraMessage?['width'] as double?;
        final name = extraMessage?['name'] as String?;
        final clientId = extraMessage['clientId'] as String?;
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return ImageMessageModel(
          id: id,
          clientId: clientId,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          roomId: roomId,
          status: StatusMessageType.convertString2StatusMessageType(status),
          type: MessageType.convertString2MessageType(type),
          size: size ?? 0,
          uri: content,
          name: name ?? '',
          content: content,
          width: width ?? 0.0,
          height: height ?? 0.0,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      case "audio":
        final name = extraMessage?['name'] as String?;
        final clientId = extraMessage['clientId'] as String?;
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return AudioMessageModel(
          id: id,
          // clientId: clientId,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          roomId: roomId,
          status: StatusMessageType.convertString2StatusMessageType(status),
          type: MessageType.convertString2MessageType(type),
          uri: content,
          content: content,
          name: name ?? '',
          isMe: isMe,
          clientId: clientId,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      case "video":
        final name = extraMessage?['name'] as String?;
        final thumbnailUrl = extraMessage?['thumbnailUrl'] as String?;
        final size = extraMessage?['size'] as double?;
        final clientId = extraMessage['clientId'] as String?;
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return VideoMessageModel(
          id: id,
          // clientId: clientId,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          roomId: roomId,
          status: StatusMessageType.convertString2StatusMessageType(status),
          type: MessageType.convertString2MessageType(type),
          size: size ?? 0,
          content: content,
          uri: content,
          thumbnailUrl: thumbnailUrl ?? '',
          isMe: isMe,
          name: name,
          clientId: clientId,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      case "file":
        final size = extraMessage?['size'] as double?;
        final name = extraMessage?['name'] as String?;
        final mimeType = extraMessage?['mimeType'] as String?;
        final clientId = extraMessage['clientId'] as String?;
        final repliedMessage = extraMessage?['repliedMessage'] as dynamic;
        final isForward = extraMessage?['isForward'] as bool?;
        ReplyMessageModel? replyMessageModel;
        if (repliedMessage != null) {
          final messageReplyRaw = ReplyMessageRaw.fromJson(repliedMessage);
          replyMessageModel = messageReplyRaw.raw2Model();
        }
        return FileMessageModel(
          id: id,
          // clientId: clientId,
          author: author != null ? author!.raw2Model() : UserModel.empty,
          createdAt: createdAt != null
              ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
              : null,
          roomId: roomId,
          status: StatusMessageType.convertString2StatusMessageType(status),
          type: MessageType.convertString2MessageType(type),
          size: size ?? 0,
          uri: content,
          name: name,
          content: content,
          mimeType: mimeType,
          clientId: clientId,
          repliedMessage: replyMessageModel,
          isForward: isForward ?? false,
        );
      default:
        throw Exception("Message type not found");
    }
  }
}

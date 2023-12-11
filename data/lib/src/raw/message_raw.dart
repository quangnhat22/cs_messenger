part of 'base_raw.dart';

@freezed
class MessageRaw extends BaseRaw<IMessageModel> with _$MessageRaw {
  MessageRaw._();

  factory MessageRaw({
    required String id,
    required UserRaw author,
    required String content,
    required String type,
    @Default(false) bool isMe,
    String? status,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'room_id') required String roomId,
    int? createdAt,
    int? deletedAt,
    String? clientId,
    String? extra,
  }) = _MessageRaw;

  factory MessageRaw.fromJson(Map<String, Object?> json) =>
      _$MessageRawFromJson(json);

  @override
  IMessageModel raw2Model() {
    switch (type) {
      case "text":
        return TextMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          author: author.raw2Model(),
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
          clientId: clientId,
        );
      // case "system":
      //   return SystemMessageModel(
      //     id: id,
      //     clientId: clientId,
      //     author: author.raw2Model(),
      //     createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
      //     repliedMessage: repliedMessage?.raw2Model(),
      //     roomId: roomId,
      //     status: StatusMessageType.convertString2StatusMessageType(status),
      //     type: MessageType.convertString2MessageType(type),
      //     metadata: metadata,
      //     text: text ?? '-',
      //   );
      // case "image":
      //   return ImageMessageModel(
      //     id: id,
      //     clientId: clientId,
      //     author: author.raw2Model(),
      //     createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
      //     repliedMessage: repliedMessage?.raw2Model(),
      //     roomId: roomId,
      //     status: StatusMessageType.convertString2StatusMessageType(status),
      //     type: MessageType.convertString2MessageType(type),
      //     metadata: metadata,
      //     size: size ?? 0,
      //     uri: uri ?? '',
      //     name: name ?? '',
      //   );
      // case "audio":
      //   return AudioMessageModel(
      //     id: id,
      //     clientId: clientId,
      //     author: author.raw2Model(),
      //     createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
      //     repliedMessage: repliedMessage?.raw2Model(),
      //     roomId: roomId,
      //     status: StatusMessageType.convertString2StatusMessageType(status),
      //     type: MessageType.convertString2MessageType(type),
      //     metadata: metadata,
      //     uri: uri ?? '',
      //     name: name ?? '',
      //   );
      // case "video":
      //   return VideoMessageModel(
      //     id: id,
      //     clientId: clientId,
      //     author: author.raw2Model(),
      //     createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
      //     repliedMessage: repliedMessage?.raw2Model(),
      //     roomId: roomId,
      //     status: StatusMessageType.convertString2StatusMessageType(status),
      //     type: MessageType.convertString2MessageType(type),
      //     metadata: metadata,
      //     size: size ?? 0,
      //     uri: uri ?? '',
      //     name: name ?? '',
      //   );
      // case "file":
      //   return FileMessageModel(
      //     id: id,
      //     clientId: clientId,
      //     author: author.raw2Model(),
      //     createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
      //     repliedMessage: repliedMessage?.raw2Model(),
      //     roomId: roomId,
      //     status: StatusMessageType.convertString2StatusMessageType(status),
      //     type: MessageType.convertString2MessageType(type),
      //     metadata: metadata,
      //     size: size ?? 0,
      //     uri: uri ?? '',
      //     name: name ?? '',
      //   );
      default:
        throw Exception("Message type not found");
    }
  }
}

// class MessageRaw extends BaseRaw<IMessageModel> with _$MessageRaw {
//   MessageRaw._();

//   factory MessageRaw({
//     required String id,
//     String? clientId,
//     required UserRaw author,
//     required int createdAt,
//     MessageRaw? repliedMessage,
//     required String roomId,
//     required String status,
//     required String type,
//     Map<String, dynamic>? metadata,
//     //for text message
//     String? text,
//     PreviewDataRaw? previewData,
//     // for image message
//     double? size,
//     String? uri,
//     String? name,
//     // for file
//     String? mimeType,
//     //for map
//     double? lat,
//     double? long,
//     //audio
//     int? duration,
//     List<double>? waveForm,
//   }) = _MessageRaw;

//   factory MessageRaw.fromJson(Map<String, Object?> json) =>
//       _$MessageRawFromJson(json);

//   @override
//   IMessageModel raw2Model() {
//     switch (type) {
//       case "text":
//         return TextMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           text: text ?? '-',
//           previewData: previewData?.raw2Model(),
//         );
//       case "system":
//         return SystemMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           text: text ?? '-',
//         );
//       case "image":
//         return ImageMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           size: size ?? 0,
//           uri: uri ?? '',
//           name: name ?? '',
//         );
//       case "audio":
//         return AudioMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           uri: uri ?? '',
//           name: name ?? '',
//         );
//       case "video":
//         return VideoMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           size: size ?? 0,
//           uri: uri ?? '',
//           name: name ?? '',
//         );
//       case "file":
//         return FileMessageModel(
//           id: id,
//           clientId: clientId,
//           author: author.raw2Model(),
//           createdAt: DateTimeExt.convertTimeStampToDateTime(createdAt),
//           repliedMessage: repliedMessage?.raw2Model(),
//           roomId: roomId,
//           status: StatusMessageType.convertString2StatusMessageType(status),
//           type: MessageType.convertString2MessageType(type),
//           metadata: metadata,
//           size: size ?? 0,
//           uri: uri ?? '',
//           name: name ?? '',
//         );
//       default:
//         throw Exception("Message type not found");
//     }
//   }
// }

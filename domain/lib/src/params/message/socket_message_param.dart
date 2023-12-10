part of '../base_param.dart';

@freezed
class SocketMessageParam extends IMessageParam with _$SocketMessageParam {
  const factory SocketMessageParam({
    @JsonKey(name: 'room_id', includeToJson: true) required String roomId,
    required String content,
    required String type,
    String? extra,
  }) = _SocketMessageParam;

  factory SocketMessageParam.fromJson(Map<String, Object?> json) =>
      _$SocketMessageParamFromJson(json);

  static SocketMessageParam convert2SocketMessageParam(
      IMessageParam messageParam, String roomId) {
    if (messageParam is TextMessageParam) {
      final meta = <String, dynamic>{
        'previewData': messageParam.previewData,
      };
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.text,
        type: MessageType.text.value,
        extra: jsonEncode(meta),
      );
    }
    switch (messageParam.runtimeType) {
      case ImageMessageParam:
        {
          final message = messageParam as ImageMessageParam;
          final meta = <String, dynamic>{
            'name': message.name,
            'width': message.width,
            'height': message.height,
            'size': message.size,
          };
          return SocketMessageParam(
            roomId: roomId,
            content: message.uri,
            type: MessageType.image.value,
            extra: jsonEncode(meta),
          );
        }
      case VideoMessageParam:
        {
          final message = messageParam as VideoMessageParam;
          final meta = <String, dynamic>{
            'thumbnailUrl': message.thumbnailUrl,
            'size': message.size,
            'name': message.name,
          };
          return SocketMessageParam(
            roomId: roomId,
            content: message.uri,
            type: MessageType.video.value,
            extra: jsonEncode(meta),
          );
        }
      case AudioMessageParam:
        {
          final message = messageParam as AudioMessageParam;
          final meta = <String, dynamic>{
            'name': message.name,
          };
          return SocketMessageParam(
            roomId: roomId,
            content: message.uri,
            type: MessageType.audio.value,
            extra: jsonEncode(meta),
          );
        }
      case FileMessageParam:
        {
          final message = messageParam as AudioMessageParam;
          final meta = <String, dynamic>{
            'name': message.name,
          };
          return SocketMessageParam(
            roomId: roomId,
            content: message.uri,
            type: MessageType.file.value,
            extra: jsonEncode(meta),
          );
        }
      case MapMessageParam:
        {
          final message = messageParam as MapMessageParam;
          final meta = <String, dynamic>{
            'name': message.name,
            'lat': message.lat,
            'long': message.long,
          };
          return SocketMessageParam(
            roomId: roomId,
            content: message.name ?? '-',
            type: MessageType.map.value,
            extra: jsonEncode(meta),
          );
        }
      case EmojiMessageParam:
        {
          final message = messageParam as EmojiMessageParam;
          return SocketMessageParam(
            roomId: roomId,
            content: message.link,
            type: MessageType.map.value,
          );
        }
      default:
        throw Exception('Message type not found');
    }
  }
}

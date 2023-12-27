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
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.text,
        type: MessageType.text.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is ImageMessageParam) {
      final meta = <String, dynamic>{
        'name': messageParam.name,
        'width': messageParam.width,
        'height': messageParam.height,
        'size': messageParam.size,
        'clientId': messageParam.clientId,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.uri,
        type: MessageType.image.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is VideoMessageParam) {
      final meta = <String, dynamic>{
        'thumbnailUrl': messageParam.thumbnailUrl,
        'size': messageParam.size,
        'name': messageParam.name,
        'clientId': messageParam.clientId,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.uri,
        type: MessageType.video.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is AudioMessageParam) {
      final meta = <String, dynamic>{
        'name': messageParam.name,
        'clientId': messageParam.clientId,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.uri,
        type: MessageType.audio.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is FileMessageParam) {
      final meta = <String, dynamic>{
        'name': messageParam.name,
        'mimeType': messageParam.mimeType,
        'size': messageParam.size,
        'clientId': messageParam.clientId,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.uri,
        type: MessageType.file.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is MapMessageParam) {
      final meta = <String, dynamic>{
        'name': messageParam.name,
        'lat': messageParam.lat,
        'long': messageParam.long,
        'clientId': messageParam.clientId,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: messageParam.name ?? '-',
        type: MessageType.map.value,
        extra: jsonEncode(meta),
      );
    } else if (messageParam is EmojiMessageParam) {
      final meta = <String, dynamic>{
        'link': messageParam.link,
        'repliedMessage': messageParam.repliedMessage,
      };
      meta.removeWhere((key, value) => value == null || value == "");
      return SocketMessageParam(
        roomId: roomId,
        content: "",
        extra: jsonEncode(meta),
        type: MessageType.emoji.value,
      );
    } else {
      throw Exception('Message type not found');
    }
  }
}

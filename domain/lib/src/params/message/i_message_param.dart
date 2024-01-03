part of '../base_param.dart';

abstract class IMessageParam extends BaseParam {
  static IMessageParam convertModel2Params(
      {required IMessageModel messageModel, String? chatRoomId}) {
    if (messageModel is TextMessageModel) {
      return TextMessageParam(text: messageModel.content);
    } else if (messageModel is ImageMessageModel) {
      return ImageMessageParam(
        uri: messageModel.uri,
        name: messageModel.name,
        width: messageModel.width,
        height: messageModel.height,
        size: messageModel.size,
        isForward: true,
      );
    } else if (messageModel is VideoMessageModel) {
      return VideoMessageParam(
        name: messageModel.name,
        size: messageModel.size,
        uri: messageModel.uri,
        thumbnailUrl: messageModel.thumbnailUrl,
        isForward: true,
      );
    } else if (messageModel is AudioMessageModel) {
      return AudioMessageParam(
        name: messageModel.name,
        uri: messageModel.uri,
        isForward: true,
      );
    } else if (messageModel is AudioMessageModel) {
      return AudioMessageParam(
        name: messageModel.name,
        uri: messageModel.uri,
        isForward: true,
      );
    } else if (messageModel is FileMessageModel) {
      return FileMessageParam(
        name: messageModel.name,
        mimeType: messageModel.mimeType,
        size: messageModel.size,
        uri: messageModel.uri,
        isLoading: false,
        isForward: true,
      );
    } else if (messageModel is EmojiStickerModel) {
      return EmojiMessageParam(
        link: messageModel.link ?? '',
        isForward: true,
      );
    } else if (messageModel is MapMessageModel) {
      return MapMessageParam(
        lat: messageModel.lat,
        long: messageModel.long,
        name: messageModel.name,
        isForward: true,
      );
    } else {
      throw Exception('Not supported this message model');
    }
  }
}

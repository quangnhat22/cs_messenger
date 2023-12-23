part of '../base_param.dart';

class IMessageParam extends BaseParam {
  static IMessageParam convertModelToParam(IMessageModel model) {
    if (model is TextMessageModel) {
      return TextMessageParam(
        roomId: model.roomId,
        text: model.content,
      );
    }
    return IMessageParam();
  }
}

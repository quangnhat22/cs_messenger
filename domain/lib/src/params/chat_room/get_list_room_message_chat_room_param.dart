part of '../base_param.dart';

enum MessageOrder {
  asc('asc'),
  desc('desc');

  const MessageOrder(this.value);
  final String value;
}

const limitMessage = 10;

@freezed
class GetListRoomMessageParam extends BaseParam with _$GetListRoomMessageParam {
  const factory GetListRoomMessageParam({
    @Default("") String offset,
    @Default(limitMessage) int limit,
    @Default('desc') String order,
    required String chatRoomId,
  }) = _GetListRoomMessageParam;

  factory GetListRoomMessageParam.fromJson(Map<String, Object?> json) =>
      _$GetListRoomMessageParamFromJson(json);
}

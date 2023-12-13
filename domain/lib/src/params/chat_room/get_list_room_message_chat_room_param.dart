part of '../base_param.dart';

enum MessageOrder {
  asc('asc'),
  desc('desc');

  const MessageOrder(this.value);
  final String value;
}

@freezed
class GetListRoomMessageParam extends BaseParam with _$GetListRoomMessageParam {
  const factory GetListRoomMessageParam({
    @Default("") String offset,
    @Default(10) int limit,
    @Default('asc') String order,
    required String chatRoomId,
  }) = _GetListRoomMessageParam;

  factory GetListRoomMessageParam.fromJson(Map<String, Object?> json) =>
      _$GetListRoomMessageParamFromJson(json);
}

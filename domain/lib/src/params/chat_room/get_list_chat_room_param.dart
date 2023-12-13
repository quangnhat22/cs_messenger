part of '../base_param.dart';

@freezed
class GetListChatRoomParam extends BaseParam with _$GetListChatRoomParam {
  const factory GetListChatRoomParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListChatRoomParam;

  factory GetListChatRoomParam.fromJson(Map<String, Object?> json) =>
      _$GetListChatRoomParamFromJson(json);
}

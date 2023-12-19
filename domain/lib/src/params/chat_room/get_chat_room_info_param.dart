part of '../base_param.dart';

@freezed
class GetChatRoomInfoParam extends BaseParam with _$GetChatRoomInfoParam {
  const factory GetChatRoomInfoParam({
    required String id,
  }) = _GetChatRoomInfoParam;

  factory GetChatRoomInfoParam.fromJson(Map<String, Object?> json) =>
      _$GetChatRoomInfoParamFromJson(json);
}

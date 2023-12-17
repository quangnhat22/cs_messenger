part of '../base_param.dart';

@freezed
class GetVideoCallTokenParam extends BaseParam with _$GetVideoCallTokenParam {
  const factory GetVideoCallTokenParam({
    required String chatRoomId,
  }) = _GetVideoCallTokenParam;

  factory GetVideoCallTokenParam.fromJson(Map<String, Object?> json) =>
      _$GetVideoCallTokenParamFromJson(json);
}

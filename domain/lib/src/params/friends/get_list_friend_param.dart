part of '../base_param.dart';

@freezed
class GetListFriendParam extends BaseParam with _$GetListFriendParam {
  const factory GetListFriendParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListFriendParam;

  factory GetListFriendParam.fromJson(Map<String, Object?> json) =>
      _$GetListFriendParamFromJson(json);
}

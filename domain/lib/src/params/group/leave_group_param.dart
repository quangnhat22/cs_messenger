part of '../base_param.dart';

@freezed
class LeaveGroupParam extends BaseParam with _$LeaveGroupParam {
  const factory LeaveGroupParam({
    required String groupId,
  }) = _LeaveGroupParam;

  factory LeaveGroupParam.fromJson(Map<String, Object?> json) =>
      _$LeaveGroupParamFromJson(json);
}

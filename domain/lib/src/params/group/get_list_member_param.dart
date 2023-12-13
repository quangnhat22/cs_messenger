part of '../base_param.dart';

@freezed
class GetListMemberGroupParam extends BaseParam with _$GetListMemberGroupParam {
  const factory GetListMemberGroupParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListMemberGroupParam;

  factory GetListMemberGroupParam.fromJson(Map<String, Object?> json) =>
      _$GetListMemberGroupParamFromJson(json);
}

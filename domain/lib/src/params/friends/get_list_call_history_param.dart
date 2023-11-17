part of '../base_param.dart';

@freezed
class GetListCallHistoryParam extends BaseParam with _$GetListCallHistoryParam {
  const factory GetListCallHistoryParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListCallHistoryParam;

  factory GetListCallHistoryParam.fromJson(Map<String, Object?> json) =>
      _$GetListCallHistoryParamFromJson(json);
}

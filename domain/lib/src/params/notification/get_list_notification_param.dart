part of '../base_param.dart';

@freezed
class GetListNotificationParam extends BaseParam
    with _$GetListNotificationParam {
  const factory GetListNotificationParam({
    @Default('en') String lang,
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListNotificationParam;

  factory GetListNotificationParam.fromJson(Map<String, Object?> json) =>
      _$GetListNotificationParamFromJson(json);
}

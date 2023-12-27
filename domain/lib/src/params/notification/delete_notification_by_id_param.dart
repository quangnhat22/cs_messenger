part of '../base_param.dart';

@freezed
class DeleteNotificationByIdParam extends BaseParam
    with _$DeleteNotificationByIdParam {
  const factory DeleteNotificationByIdParam({
    String? id,
  }) = _DeleteNotificationByIdParam;

  factory DeleteNotificationByIdParam.fromJson(Map<String, Object?> json) =>
      _$DeleteNotificationByIdParamFromJson(json);
}

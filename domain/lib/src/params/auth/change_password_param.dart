part of '../base_param.dart';

@freezed
class ChangePasswordParam extends BaseParam with _$ChangePasswordParam {
  const factory ChangePasswordParam({
    @JsonKey(name: 'old_password') required String oldPassword,
    @JsonKey(name: 'new_password') required String newPassword,
  }) = _ChangePasswordParam;

  factory ChangePasswordParam.fromJson(Map<String, Object?> json) =>
      _$ChangePasswordParamFromJson(json);
}

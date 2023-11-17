part of '../base_param.dart';

@freezed
class SignUpParam extends BaseParam with _$SignUpParam {
  const factory SignUpParam({
    required String email,
    required String password,
  }) = _SignUpParam;

  factory SignUpParam.fromJson(Map<String, Object?> json) =>
      _$SignUpParamFromJson(json);
}

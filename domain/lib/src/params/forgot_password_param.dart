part of 'base_param.dart';

@freezed
class ForgotPasswordParam extends BaseParam with _$ForgotPasswordParam {
  const factory ForgotPasswordParam({
    required String email,
  }) = _ForgotPasswordParam;

  factory ForgotPasswordParam.fromJson(Map<String, Object?> json) =>
      _$ForgotPasswordParamFromJson(json);
}

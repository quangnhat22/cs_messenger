part of 'base_param.dart';

@freezed
class LoginWithEmailParam extends BaseParam with _$LoginWithEmailParam {
  const factory LoginWithEmailParam({
    required String email,
    required String password,
  }) = _LoginWithEmailParam;

  factory LoginWithEmailParam.fromJson(Map<String, Object?> json) =>
      _$LoginWithEmailParamFromJson(json);
}

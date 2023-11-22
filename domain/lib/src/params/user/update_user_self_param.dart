part of '../base_param.dart';

@freezed
class UpdateUserSelfParam extends BaseParam with _$UpdateUserSelfParam {
  const factory UpdateUserSelfParam({
    String? name,
    String? gender,
    String? phone,
    String? avatar,
    int? birthday,
    String? bio,
  }) = _UpdateUserSelfParam;

  factory UpdateUserSelfParam.fromJson(Map<String, Object?> json) =>
      _$UpdateUserSelfParamFromJson(json);
}

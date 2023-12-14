part of '../base_param.dart';

@freezed
class EditGroupParam extends BaseParam with _$EditGroupParam {
  const factory EditGroupParam({
    required String name,
    String? avatar,
    List<String>? members,
  }) = _EditGroupParam;

  factory EditGroupParam.fromJson(Map<String, Object?> json) =>
      _$EditGroupParamFromJson(json);
}

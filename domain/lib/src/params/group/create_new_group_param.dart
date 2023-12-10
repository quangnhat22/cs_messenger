part of '../base_param.dart';

@freezed
class CreateNewGroupParam extends BaseParam with _$CreateNewGroupParam {
  const factory CreateNewGroupParam({
    required String name,
    String? avatar,
    List<String>? members,
  }) = _CreateNewGroupParam;

  factory CreateNewGroupParam.fromJson(Map<String, Object?> json) =>
      _$CreateNewGroupParamFromJson(json);
}

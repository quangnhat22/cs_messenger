part of '../base_param.dart';

@freezed
class ActionRequestParam extends BaseParam with _$ActionRequestParam {
  const factory ActionRequestParam({
    String? id,
  }) = _ActionRequestParam;

  factory ActionRequestParam.fromJson(Map<String, Object?> json) =>
      _$ActionRequestParamFromJson(json);
}

part of '../base_param.dart';

@freezed
class SearchParam extends BaseParam with _$SearchParam {
  const factory SearchParam({
    String? query,
  }) = _SearchParam;

  factory SearchParam.fromJson(Map<String, Object?> json) =>
      _$SearchParamFromJson(json);
}

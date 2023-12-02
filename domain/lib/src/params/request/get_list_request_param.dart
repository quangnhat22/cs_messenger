part of '../base_param.dart';

@freezed
class GetListRequestParam extends BaseParam with _$GetListRequestParam {
  const factory GetListRequestParam({
    @JsonKey(name: 'request_type') required String type,
    required String direction,
    @Default(1) int page,
    @Default(10) int limit,
  }) = _GetListRequestParam;

  factory GetListRequestParam.fromJson(Map<String, Object?> json) =>
      _$GetListRequestParamFromJson(json);
}

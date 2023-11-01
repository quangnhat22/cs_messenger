part of 'base_param.dart';

@freezed
class GetListGroupParam extends BaseParam with _$GetListGroupParam {
  const factory GetListGroupParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListGroupParam;

  factory GetListGroupParam.fromJson(Map<String, Object?> json) =>
      _$GetListGroupParamFromJson(json);
}

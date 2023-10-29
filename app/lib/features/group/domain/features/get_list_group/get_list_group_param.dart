import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../../generated/features/group/domain/features/get_list_group/get_list_group_param.freezed.dart';
part '../../../../../generated/features/group/domain/features/get_list_group/get_list_group_param.g.dart';

@freezed
class GetListGroupParam extends BaseParam with _$GetListGroupParam {
  const factory GetListGroupParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListGroupParam;

  factory GetListGroupParam.fromJson(Map<String, Object?> json) =>
      _$GetListGroupParamFromJson(json);
}

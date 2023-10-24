import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../../generated/features/friend/domain/features/get_list_call_history/get_list_call_history_param.freezed.dart';
part '../../../../../generated/features/friend/domain/features/get_list_call_history/get_list_call_history_param.g.dart';

@freezed
class GetListCallHistoryParam extends BaseParam with _$GetListCallHistoryParam {
  const factory GetListCallHistoryParam({
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListCallHistoryParam;

  factory GetListCallHistoryParam.fromJson(Map<String, Object?> json) =>
      _$GetListCallHistoryParamFromJson(json);
}

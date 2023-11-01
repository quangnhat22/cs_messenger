part of 'base_param.dart';

@freezed
class GetListFriendRequestParam extends BaseParam
    with _$GetListFriendRequestParam {
  const factory GetListFriendRequestParam({
    @Default('') String type,
    @Default('') String direction,
    @Default(1) int page,
    @Default(10) int pageSize,
  }) = _GetListFriendRequestParam;

  factory GetListFriendRequestParam.fromJson(Map<String, Object?> json) =>
      _$GetListFriendRequestParamFromJson(json);
}

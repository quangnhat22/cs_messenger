import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../../generated/features/friend/domain/features/get_list_friend_request/get_list_friend_request_param.freezed.dart';
part '../../../../../generated/features/friend/domain/features/get_list_friend_request/get_list_friend_request_param.g.dart';

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

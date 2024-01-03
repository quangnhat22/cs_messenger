part of 'group_info_cubit.dart';

@freezed
class GroupInfoState with _$GroupInfoState {
  const factory GroupInfoState.initial({
    String? chatRoomId,
    String? name,
    String? avatar,
    @Default(0) int numberOfMembers,
    DateTime? createdAt,
    UserModel? userCreate,
  }) = _Initial;
}

part of 'edit_group_cubit.dart';

@freezed
class EditGroupState with _$EditGroupState {
  const factory EditGroupState.initial({
    String? groupId,
    String? chatRoomId,
    String? name,
    String? avatarUrl,
  }) = _Initial;
}

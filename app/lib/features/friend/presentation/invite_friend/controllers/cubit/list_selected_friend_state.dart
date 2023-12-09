part of 'list_selected_friend_cubit.dart';

@freezed
class ListSelectedFriendState with _$ListSelectedFriendState {
  const factory ListSelectedFriendState.initial({
    @Default([]) List<UserModel> selectedMembers,
  }) = _Initial;
}

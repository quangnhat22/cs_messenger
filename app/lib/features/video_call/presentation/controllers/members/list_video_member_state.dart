part of 'list_video_member_cubit.dart';

@freezed
class ListVideoMemberState with _$ListVideoMemberState {
  const factory ListVideoMemberState.initial({
    @Default([]) List<UserModel> listMembers,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
  }) = _Initial;
}

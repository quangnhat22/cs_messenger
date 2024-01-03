part of 'base_raw.dart';

@freezed
class SearchRaw extends BaseRaw<SearchModel> with _$SearchRaw {
  SearchRaw._();

  factory SearchRaw({
    List<UserRaw>? users,
    @JsonKey(name: 'recommended_friends') List<UserRaw>? recommendedFriend,
    List<ChatRoomRaw>? messages,
    List<GroupRaw>? groups,
  }) = _SearchRaw;

  factory SearchRaw.fromJson(Map<String, Object?> json) =>
      _$SearchRawFromJson(json);

  @override
  SearchModel raw2Model() {
    return SearchModel(
      users: users?.map((user) => user.raw2Model()).toList(),
      recommendedFriend:
          recommendedFriend?.map((friend) => friend.raw2Model()).toList(),
      messages: messages?.map((message) => message.raw2Model()).toList(),
      groups: groups?.map((groups) => groups.raw2Model()).toList(),
    );
  }
}

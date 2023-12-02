part of 'base_raw.dart';

@freezed
class SearchRaw extends BaseRaw<SearchModel> with _$SearchRaw {
  SearchRaw._();

  factory SearchRaw({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'users') List<UserRaw>? users,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'friends') List<UserRaw>? friends,
  }) = _SearchRaw;

  factory SearchRaw.fromJson(Map<String, Object?> json) =>
      _$SearchRawFromJson(json);

  @override
  SearchModel raw2Model() {
    return SearchModel(
      users: users?.map((user) => user.raw2Model()).toList(),
      friends: friends?.map((friend) => friend.raw2Model()).toList(),
    );
  }
}

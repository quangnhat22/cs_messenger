part of 'base_raw.dart';

@freezed
class GroupRaw extends BaseRaw<GroupModel> with _$GroupRaw {
  GroupRaw._();

  factory GroupRaw({
    required String id,
    required String name,
    String? avatar,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'room_id') required String roomId,
  }) = _GroupRaw;

  factory GroupRaw.fromJson(Map<String, Object?> json) =>
      _$GroupRawFromJson(json);

  @override
  GroupModel raw2Model() {
    return GroupModel(
      id: id,
      name: name,
      avatar: avatar,
      roomId: roomId,
    );
  }
}

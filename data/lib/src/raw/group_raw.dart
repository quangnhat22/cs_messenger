part of 'base_raw.dart';

@freezed
class GroupRaw extends BaseRaw<GroupModel> with _$GroupRaw {
  GroupRaw._();

  factory GroupRaw({
    required String id,
    required String name,
  }) = _GroupRaw;

  factory GroupRaw.fromJson(Map<String, Object?> json) =>
      _$GroupRawFromJson(json);

  @override
  GroupModel raw2Model() {
    return GroupModel(
      id: id,
      name: name,
    );
  }
}

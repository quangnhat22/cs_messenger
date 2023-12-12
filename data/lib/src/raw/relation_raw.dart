part of 'base_raw.dart';

@freezed
class RelationRaw extends BaseRaw<RelationModel> with _$RelationRaw {
  RelationRaw._();

  factory RelationRaw({
    String? relation,
    @JsonKey(name: "room_id") String? roomId,
  }) = _RelationRaw;

  factory RelationRaw.fromJson(Map<String, Object?> json) =>
      _$RelationRawFromJson(json);

  @override
  RelationModel raw2Model() {
    return RelationModel(
      relation: RelationType.convertStringToRelationType(relation),
      roomId: roomId,
    );
  }
}

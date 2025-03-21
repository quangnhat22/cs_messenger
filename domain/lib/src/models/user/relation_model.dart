part of '../base_model.dart';

enum RelationType {
  empty('empty'),
  self('self'),
  friend('friend'),
  stranger('stranger'),
  blocking('blocking'),
  requesting('requesting'),
  requested('requested');

  const RelationType(this.value);

  final String value;

  static RelationType convertStringToRelationType(String? type) {
    if (RelationType.self.value == type) {
      return RelationType.self;
    } else if (RelationType.friend.value == type) {
      return RelationType.friend;
    } else if (RelationType.blocking.value == type) {
      return RelationType.blocking;
    } else if (RelationType.requesting.value == type) {
      return RelationType.requesting;
    } else if (RelationType.requested.value == type) {
      return RelationType.requested;
    } else if (RelationType.stranger.value == type) {
      return RelationType.stranger;
    } else {
      return RelationType.stranger;
    }
  }
}

class RelationModel extends BaseModel {
  final RelationType? relation;
  final String? roomId;

  RelationModel({
    this.relation,
    this.roomId,
  });
}

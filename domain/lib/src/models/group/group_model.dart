part of '../base_model.dart';

class GroupModel extends BaseModel {
  final String id;
  final String name;
  final String? avatar;
  final String roomId;

  GroupModel(
      {required this.id,
      required this.name,
      this.avatar,
      required this.roomId});
}

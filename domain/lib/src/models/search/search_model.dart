part of '../base_model.dart';

class SearchModel extends BaseModel {
  final List<UserModel>? users;
  final List<UserModel>? friends;
  final List<GroupModel>? groups;

  SearchModel({
    this.users,
    this.friends,
    this.groups,
  });
}

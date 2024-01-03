part of '../base_model.dart';

class SearchModel extends BaseModel {
  final List<UserModel>? users;
  final List<UserModel>? recommendedFriend;
  final List<GroupModel>? groups;
  final List<ChatRoomModel>? messages;

  SearchModel({
    this.users,
    this.recommendedFriend,
    this.groups,
    this.messages,
  });
}

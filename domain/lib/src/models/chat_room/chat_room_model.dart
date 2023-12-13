part of '../base_model.dart';

class ChatRoomModel extends BaseModel {
  final String id;
  final String? name;
  final String? avatar;

  ChatRoomModel({required this.id, this.name, this.avatar});
}

part of '../base_model.dart';

enum NotificationObjectType {
  user("user"),
  request("request"),
  empty("");

  const NotificationObjectType(this.value);

  final String value;

  static NotificationObjectType convertString2Enum(String value) {
    if (value == NotificationObjectType.user.value) {
      return NotificationObjectType.user;
    } else if (value == NotificationObjectType.request.value) {
      return NotificationObjectType.request;
    } else {
      return NotificationObjectType.empty;
    }
  }
}

class NotificationObjectModel extends BaseModel {
  final String? id;
  final String? name;
  final String? image;
  final NotificationObjectType? type;

  NotificationObjectModel({
    this.id,
    this.name,
    this.image,
    this.type,
  });
}

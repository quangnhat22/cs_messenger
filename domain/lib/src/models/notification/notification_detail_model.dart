part of '../base_model.dart';

enum NotificationActionType {
  receiveFriendRequest("receive-friend-request"),
  acceptRequest("accept-request"),
  receiveGroupRequest("receive-group-request");

  const NotificationActionType(this.value);

  final String value;

  static NotificationActionType convertString2Enum(String value) {
    if (value == NotificationActionType.receiveFriendRequest.value) {
      return NotificationActionType.receiveFriendRequest;
    } else if (value == NotificationActionType.acceptRequest.value) {
      return NotificationActionType.acceptRequest;
    } else if (value == NotificationActionType.receiveGroupRequest.value) {
      return NotificationActionType.receiveGroupRequest;
    } else {
      throw const FormatException('No Notification Object Type Support');
    }
  }
}

class NotificationDetailModel extends BaseModel {
  final NotificationObjectModel? subject;
  final NotificationObjectModel? direct;
  final NotificationObjectModel? indirect;
  final NotificationObjectModel? prep;
  final NotificationActionType? action;
  final DateTime? createdAt;

  NotificationDetailModel({
    this.subject,
    this.direct,
    this.indirect,
    this.prep,
    this.action,
    this.createdAt,
  });
}

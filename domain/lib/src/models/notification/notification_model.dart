part of '../base_model.dart';

class NotificationModel extends BaseModel {
  final String? id;
  final String heading;
  final String content;
  final NotificationDetailModel? details;

  NotificationModel({
    this.id,
    required this.heading,
    required this.content,
    this.details,
  });
}

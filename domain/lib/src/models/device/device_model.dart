part of '../base_model.dart';

class DeviceModel extends BaseModel {
  final String id;
  final String? model;
  final String? os;
  final String? appVersion;
  final DateTime? lastActive;

  DeviceModel(
      {required this.id,
      this.model,
      this.os,
      this.appVersion,
      this.lastActive});
}

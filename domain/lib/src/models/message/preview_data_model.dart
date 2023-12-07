part of '../base_model.dart';

class PreviewDataModel extends BaseModel {
  final String? title;
  final String? description;
  final String? image;
  final String? link;
  final double? width;
  final double? height;

  PreviewDataModel({
    this.title,
    this.description,
    this.image,
    this.link,
    this.width,
    this.height,
  });
}

part of 'base_raw.dart';

@freezed
class PreviewDataRaw extends BaseRaw<PreviewDataModel> with _$PreviewDataRaw {
  PreviewDataRaw._();

  factory PreviewDataRaw({
    String? title,
    String? description,
    String? image,
    String? link,
  }) = _PreviewDataRaw;

  factory PreviewDataRaw.fromJson(Map<String, Object?> json) =>
      _$PreviewDataRawFromJson(json);

  @override
  PreviewDataModel raw2Model() {
    return PreviewDataModel(
      title: title,
      description: description,
      image: image,
      link: link,
    );
  }
}

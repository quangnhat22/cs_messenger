part of '../base_param.dart';

@freezed
class EditGroupParam extends BaseParam with _$EditGroupParam {
  const factory EditGroupParam({
    // ignore: invalid_annotation_target
    @JsonKey(includeToJson: false) required String groupId,
    String? name,
    String? avatar,
  }) = _EditGroupParam;

  factory EditGroupParam.fromJson(Map<String, Object?> json) =>
      _$EditGroupParamFromJson(json);
}

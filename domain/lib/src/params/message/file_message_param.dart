part of '../base_param.dart';

@freezed
class FileMessageParam extends IMessageParam with _$FileMessageParam {
  const factory FileMessageParam({
    String? mimeType,
    @Default(0) double size,
    required String uri,
    String? name,
    bool? isLoading,
  }) = _FileMessageParam;

  factory FileMessageParam.fromJson(Map<String, Object?> json) =>
      _$FileMessageParamFromJson(json);
}

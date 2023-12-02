part of '../base_param.dart';

@freezed
class SentRequestParam extends BaseParam with _$SentRequestParam {
  const factory SentRequestParam({
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'group_id') String? groupId,
  }) = _SentRequestParam;

  factory SentRequestParam.fromJson(Map<String, Object?> json) =>
      _$SentRequestParamFromJson(json);
}

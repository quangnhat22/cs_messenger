part of 'base_raw.dart';

@freezed
class RequestRaw extends BaseRaw<RequestModel> with _$RequestRaw {
  RequestRaw._();

  factory RequestRaw({
    required String id,
    UserRaw? sender,
    UserRaw? receiver,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at') int? createdAt,
  }) = _RequestRaw;

  factory RequestRaw.fromJson(Map<String, Object?> json) =>
      _$RequestRawFromJson(json);

  @override
  RequestModel raw2Model() {
    return RequestModel(
      id: id,
      sender: sender?.raw2Model(),
      createdAt: createdAt != null
          ? DateTimeExt.convertTimeStampToDateTime(createdAt!)
          : null,
      receiver: receiver?.raw2Model(),
    );
  }
}

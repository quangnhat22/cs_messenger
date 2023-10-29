part of 'base_raw.dart';

@freezed
class RequestRaw extends BaseRaw<RequestModel> with _$RequestRaw {
  RequestRaw._();

  factory RequestRaw({
    required String id,
    UserRaw? sender,
    UserRaw? receiver,
  }) = _RequestRaw;

  factory RequestRaw.fromJson(Map<String, Object?> json) =>
      _$RequestRawFromJson(json);

  @override
  RequestModel raw2Model() {
    return RequestModel(
      id: id,
      sender: sender?.raw2Model(),
      receiver: receiver?.raw2Model(),
    );
  }
}

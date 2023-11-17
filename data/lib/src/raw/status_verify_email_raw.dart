part of 'base_raw.dart';

@freezed
class StatusVerifyEmailRaw extends BaseRaw<StatusVerifyEmailModel>
    with _$StatusVerifyEmailRaw {
  StatusVerifyEmailRaw._();

  factory StatusVerifyEmailRaw(
          {@JsonKey(name: 'is_verify') required bool isVerify}) =
      _StatusVerifyEmailRaw;

  factory StatusVerifyEmailRaw.fromJson(Map<String, Object?> json) =>
      _$StatusVerifyEmailRawFromJson(json);

  @override
  StatusVerifyEmailModel raw2Model() {
    return StatusVerifyEmailModel(isVerify: isVerify);
  }
}

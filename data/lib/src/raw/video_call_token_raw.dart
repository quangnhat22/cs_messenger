part of 'base_raw.dart';

@freezed
class VideoCallTokenRaw extends BaseRaw<VideoCallTokenModel>
    with _$VideoCallTokenRaw {
  VideoCallTokenRaw._();

  factory VideoCallTokenRaw({
    required String token,
  }) = _VideoCallTokenRaw;

  factory VideoCallTokenRaw.fromJson(Map<String, Object?> json) =>
      _$VideoCallTokenRawFromJson(json);

  @override
  VideoCallTokenModel raw2Model() {
    return VideoCallTokenModel(token: token);
  }
}

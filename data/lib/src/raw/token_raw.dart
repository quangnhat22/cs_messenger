part of 'base_raw.dart';

@freezed
class TokenRaw extends BaseRaw<TokenModel> with _$TokenRaw {
  TokenRaw._();

  factory TokenRaw({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'access_token') String? accessToken,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _TokenRaw;

  factory TokenRaw.fromJson(Map<String, Object?> json) =>
      _$TokenRawFromJson(json);

  @override
  TokenModel raw2Model() {
    return TokenModel(accessToken: accessToken, refreshToken: refreshToken);
  }
}

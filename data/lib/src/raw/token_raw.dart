part of 'base_raw.dart';

@freezed
class TokenRaw extends BaseRaw<TokenModel> with _$TokenRaw {
  TokenRaw._();

  factory TokenRaw({
    String? accessToken,
    String? refreshToken,
  }) = _TokenRaw;

  factory TokenRaw.fromJson(Map<String, Object?> json) =>
      _$TokenRawFromJson(json);

  @override
  TokenModel raw2Model() {
    return TokenModel(accessToken: accessToken, refreshToken: refreshToken);
  }
}

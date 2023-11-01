part of 'base_raw.dart';

@freezed
class WelcomeRaw extends BaseRaw<WelcomeModel> with _$WelcomeRaw {
  WelcomeRaw._();

  factory WelcomeRaw({
    bool? isFirstInstall,
  }) = _WelcomeRaw;

  factory WelcomeRaw.fromJson(Map<String, Object?> json) =>
      _$WelcomeRawFromJson(json);

  @override
  WelcomeModel raw2Model() {
    return WelcomeModel(isFirstInstall: isFirstInstall);
  }
}

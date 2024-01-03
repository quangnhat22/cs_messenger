part of 'about_us_cubit.dart';

@freezed
class AboutUsState with _$AboutUsState {
  const factory AboutUsState.initial({
    String? appName,
    String? appVersion,
    String? emailContact,
  }) = _Initial;
}

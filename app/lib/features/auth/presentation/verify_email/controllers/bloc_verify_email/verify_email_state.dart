part of 'verify_email_cubit.dart';

@freezed
class VerifyEmailState with _$VerifyEmailState {
  const factory VerifyEmailState.initial({
    String? email,
    DateTime? expireTime,
    @Default(true) bool isFirstRequestSendEmail,
    @Default(false) bool isSendEmailSuccess,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isVerifying,
  }) = _Initial;
}

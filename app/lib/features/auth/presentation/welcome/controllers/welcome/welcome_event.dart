part of 'welcome_bloc.dart';

@freezed
class WelcomeEvent with _$WelcomeEvent {
  const factory WelcomeEvent.started() = _Started;

  const factory WelcomeEvent.loginWithGoogle() = WelcomeLoginWithGoogle;

  const factory WelcomeEvent.checkAuthenticated() =
      WelcomeCheckLoginAuthenticated;
}

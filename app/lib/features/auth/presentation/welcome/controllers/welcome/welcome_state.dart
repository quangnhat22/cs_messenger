part of 'welcome_bloc.dart';

@freezed
class WelcomeState with _$WelcomeState {
  const factory WelcomeState.initial({
    @Default(false) bool isFirstInstall,
    @Default(false) bool isAuthenticated,
    @Default(true) bool isLoading,
  }) = _Initial;
}

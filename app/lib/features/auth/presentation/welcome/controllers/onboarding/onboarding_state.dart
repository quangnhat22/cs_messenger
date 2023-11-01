part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial({
    @Default(false) bool isLoading,
  }) = _Initial;
}

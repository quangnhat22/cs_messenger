import 'package:app/features/auth/domain/usecases/onboarding/update_is_first_installed_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  late final UpdateIsFirstInstalledUseCase _updateIsFirstInstalledUseCase;

  OnboardingCubit(this._updateIsFirstInstalledUseCase)
      : super(const OnboardingState.initial());

  Future<void> updateValueFirstInstall() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    await _updateIsFirstInstalledUseCase.executeObj();
    emit(state.copyWith(
      isLoading: false,
    ));
  }
}

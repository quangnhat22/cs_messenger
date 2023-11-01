import 'package:app/features/auth/domain/usecases/onboarding/get_is_first_installed_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'welcome_bloc.freezed.dart';
part 'welcome_event.dart';
part 'welcome_state.dart';

@Injectable()
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  late final GetIsFirstInstalledUseCase _getIsFirstInstalledUseCase;

  WelcomeBloc(this._getIsFirstInstalledUseCase)
      : super(const WelcomeState.initial()) {
    on<WelcomeEvent>((event, emit) async {
      await event.map(
        started: (event) async => await _started(event, emit),
      );
    });
  }

  Future<void> _started(_Started event, Emitter<WelcomeState> emit) async {
    final welcomeModel = await _getIsFirstInstalledUseCase.executeObj();

    //check first install
    final isFirstInstall = welcomeModel.netData?.isFirstInstall ?? true;

    emit(state.copyWith(
      isFirstInstall: isFirstInstall,
      isLoading: false,
    ));
  }
}

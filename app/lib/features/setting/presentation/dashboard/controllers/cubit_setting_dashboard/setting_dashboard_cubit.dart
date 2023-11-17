import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/logout_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

part 'setting_dashboard_cubit.freezed.dart';
part 'setting_dashboard_state.dart';

@Injectable()
class SettingDashboardCubit extends Cubit<SettingDashboardState> {
  late final LogOutUseCase _logOutUseCase;

  SettingDashboardCubit(this._logOutUseCase)
      : super(const SettingDashboardState.initial());

  Future<void> logOut() async {
    try {
      await _logOutUseCase.executeObj();
      await getIt<AppRouter>().replace(const WelcomeRoute());
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.logOutFail)
                .setContent(R.strings.errorOccurred)
                .setPositiveText(R.strings.confirm)
                .show();
          }).detected();
    }
  }
}

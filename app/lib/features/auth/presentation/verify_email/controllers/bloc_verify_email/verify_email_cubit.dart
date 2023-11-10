import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/features/auth/domain/usecases/auth/force_logout_uc.dart';
import 'package:app/features/auth/domain/usecases/email/get_verify_email_token_uc.dart';
import 'package:app/features/auth/domain/usecases/email/verify_email_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

part 'verify_email_cubit.freezed.dart';
part 'verify_email_state.dart';

@Injectable()
class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  late final VerifyEmailUseCase _verifyEmailUseCase;
  late final GetVerifyEmailTokenUseCase _getVerifyEmailTokenUseCase;
  late final ForceLogOutUseCase _forceLogOutUseCase;

  VerifyEmailCubit(
    this._verifyEmailUseCase,
    this._getVerifyEmailTokenUseCase,
    this._forceLogOutUseCase,
  ) : super(const VerifyEmailState.initial());

  void initPage(bool isFirstRequestSendEmail) async {
    try {
      final verifyEmailObjectLocal =
          await _getVerifyEmailTokenUseCase.executeObj();

      emit(state.copyWith(
        isFirstRequestSendEmail: isFirstRequestSendEmail,
        email: verifyEmailObjectLocal.netData?.email,
        expireTime: verifyEmailObjectLocal.netData?.expireTime,
      ));

      if (isFirstRequestSendEmail) {
        AppSnackBarWidget()
            .setLabelText(R.strings.sendEmailSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
      }
    } on AppException catch (e) {
      AppExceptionExt(
        appException: e,
        onError: (_) {
          AppDefaultDialogWidget()
              .setTitle(R.strings.error)
              .setContent(R.strings.systemIsCurrentlyErrorPleaseTryAgainLater)
              .setAppDialogType(AppDialogType.error)
              .setNegativeText(R.strings.close)
              .setPositiveText(R.strings.confirm)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        },
      );
    }
  }

  Future<void> logOut() async {
    try {
      await _forceLogOutUseCase.executeObj();
      await getIt<AppRouter>().pop();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.errorOccurred)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }
}

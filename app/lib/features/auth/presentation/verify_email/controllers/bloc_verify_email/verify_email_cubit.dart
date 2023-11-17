import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/features/auth/domain/usecases/auth/force_logout_uc.dart';
import 'package:app/features/auth/domain/usecases/auth/logout_uc.dart';
import 'package:app/features/auth/domain/usecases/email/get_verify_email_token_uc.dart';
import 'package:app/features/auth/domain/usecases/email/request_send_verify_email_uc.dart';
import 'package:app/features/auth/domain/usecases/email/verify_email_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part 'verify_email_cubit.freezed.dart';
part 'verify_email_state.dart';

@Injectable()
class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  late final CheckVerifyEmailUseCase _checkVerifyEmailUseCase;
  late final RequestSendVerifyEmailUseCase _requestSendVerifyEmailUseCase;
  late final GetVerifyEmailTokenUseCase _getVerifyEmailTokenUseCase;
  late final ForceLogOutUseCase _forceLogOutUseCase;
  late final LogOutUseCase _logOutUseCase;

  VerifyEmailCubit(
    this._checkVerifyEmailUseCase,
    this._getVerifyEmailTokenUseCase,
    this._forceLogOutUseCase,
    this._requestSendVerifyEmailUseCase,
    this._logOutUseCase,
  ) : super(const VerifyEmailState.initial());

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

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
        emit(state.copyWith(isVerifying: true));
        //show snack bar
        AppSnackBarWidget()
            .setLabelText(R.strings.sendEmailSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
        await checkVerifyEmail();
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

  Future<void> requestSendVerifyEmail() async {
    try {
      await _requestSendVerifyEmailUseCase.executeObj();
      if (!state.isVerifying) {
        checkVerifyEmail();
      }
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

  Future<void> checkVerifyEmail() async {
    try {
      emit(state.copyWith(isVerifying: true));
      _timer = Timer.periodic(
          Duration(milliseconds: AppConstants.timeRepeatCallCheckVerifyEmail),
          (timer) async {
        final statusVerifyModel = await _checkVerifyEmailUseCase.executeObj();
        final statusVerify = statusVerifyModel.netData?.isVerify ?? false;
        if (statusVerify) {
          AppSnackBarWidget()
              .setLabelText(R.strings.thankForVerifyEmail)
              .setAppSnackBarType(AppSnackBarType.informMessage)
              .setAppSnackBarStatus(AppSnackBarStatus.success)
              .showSnackBar();
          await logOut();
        }
        Logs.d('tick ${timer.tick}');
      });
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await _logOutUseCase.executeObj();
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

import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:app/features/auth/domain/usecases/auth/change_password_usecase.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

@Injectable()
class ChangePasswordFormBloc extends FormBloc<String, String> {
  late final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordFormBloc(this._changePasswordUseCase) {
    addFieldBlocs(fieldBlocs: [
      currentPassword,
      newPassword,
      confirmNewPassword,
    ]);

    confirmNewPassword
      ..addValidators([_confirmPassword(newPassword)])
      ..subscribeToFieldBlocs([newPassword]);
  }

  final currentPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      AppFormValidatorExt.validatePassword
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final newPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      AppFormValidatorExt.validatePassword
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final confirmNewPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return R.strings.confirmPasswordNotMatch;
    };
  }

  @override
  Future<void> onSubmitting() async {
    try {
      AppLoadingOverlayWidget.show();
      emitSubmitting();
      await _changePasswordUseCase.executeObj(
          request: ChangePasswordParam(
              oldPassword: currentPassword.value,
              newPassword: newPassword.value));
      emitSuccess();
      AppLoadingOverlayWidget.dismiss();
      AppSnackBarWidget()
          .setLabelText(R.strings.changePasswordSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            emitFailure();
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

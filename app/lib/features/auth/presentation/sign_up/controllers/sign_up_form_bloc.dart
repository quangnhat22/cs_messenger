import 'dart:async';

import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:app/features/auth/domain/usecases/auth/create_new_account_uc.dart';
import 'package:app/features/auth/domain/usecases/auth/login_with_email_unverify_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

@Injectable()
class SignUpFormBloc extends FormBloc<String, String> {
  final CreateNewAccountUseCase _createNewAccountUseCase;
  final LoginWithEmailUnVerifyUseCase _loginWithEmailUnVerifyUseCase;

  SignUpFormBloc(
      this._createNewAccountUseCase, this._loginWithEmailUnVerifyUseCase) {
    addFieldBlocs(fieldBlocs: [
      email,
      password,
      confirmPassword,
    ]);

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
  }

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      AppFormValidatorExt.validateEmail
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      AppFormValidatorExt.validatePassword
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final confirmPassword = TextFieldBloc(
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
  FutureOr<void> onSubmitting() async {
    try {
      AppLoadingOverlayWidget.show();
      await _createNewAccountUseCase.executeObj(
          request: SignUpParam(email: email.value, password: password.value));

      await _loginWithEmailUnVerifyUseCase.executeObj(
        request:
            LoginWithEmailParam(email: email.value, password: password.value),
      );

      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
        appException: e,
        onError: (_) {
          emitFailure();
        },
      ).detected();
    }
  }
}

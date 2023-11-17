import 'dart:async';

import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

@Injectable()
class ChangePasswordFormBloc extends FormBloc<String, String> {
  ChangePasswordFormBloc() {
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
  Future<void> onSubmitting() async {}
}

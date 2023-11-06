import 'dart:async';

import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SignUpFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  final confirmPassword = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      return (String? confirmPassword) {
        if (confirmPassword == null ||
            confirmPassword.isEmpty ||
            confirmPassword == passwordTextFieldBloc.value) {
          return null;
        }
        return FieldBlocValidatorsErrors.confirmPassword;
      };
    };
  }

  SignUpFormBloc() {
    addFieldBlocs(fieldBlocs: [
      email,
      password,
      confirmPassword,
    ]);

    email..addValidators([AppFormValidatorExt.email(e)])

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }
}

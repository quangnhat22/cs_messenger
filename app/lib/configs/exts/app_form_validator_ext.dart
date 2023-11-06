import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

class AppFormValidatorExt {
  AppFormValidatorExt._();

  static String? email(String? string) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (string == null || string.isEmpty || emailRegExp.hasMatch(string)) {
      return null;
    }

    return R.strings.emailValidate;
  }

  Validator<String> confirmPassword(
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
}

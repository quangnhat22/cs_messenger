import 'package:resources/resources.dart';

class AppFormValidatorExt {
  AppFormValidatorExt._();

  static String? validateEmail(String? string) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    if (string == null || string.isEmpty || emailRegExp.hasMatch(string)) {
      return null;
    }
    return R.strings.emailValidate;
  }

  static String? validatePassword(String? string) {
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

    if (string == null || string.isEmpty || passwordRegExp.hasMatch(string)) {
      return null;
    }
    return R.strings.passwordValidate;
  }

  static String? validatePhoneNumber(String? string) {
    final passwordRegExp = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');

    if (string == null || string.isEmpty || passwordRegExp.hasMatch(string)) {
      return null;
    }
    return R.strings.phoneNumberIsNotValid;
  }
}

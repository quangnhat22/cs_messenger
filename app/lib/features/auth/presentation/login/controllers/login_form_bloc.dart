import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/login_with_email_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

@Injectable()
class LoginFormBloc extends FormBloc<String, String> {
  late final LoginWithEmailUseCase _loginWithEmailUseCase;

  LoginFormBloc(this._loginWithEmailUseCase) {
    addFieldBlocs(fieldBlocs: [email, password]);
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

  @override
  FutureOr<void> onSubmitting() async {
    try {
      AppLoadingOverlayWidget.show();
      await _loginWithEmailUseCase.executeObj(
          request: LoginWithEmailParam(
              email: email.value, password: password.value));
      AppLoadingOverlayWidget.dismiss();
      //back to welcome
      AppSnackBarWidget()
          .setLabelText(R.strings.createAccountSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();

      //go to login page after creating new account success
      await getIt<AppRouter>().replace(const WelcomeRoute());
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      emitFailure();
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
      ).detected();
    }
  }
}

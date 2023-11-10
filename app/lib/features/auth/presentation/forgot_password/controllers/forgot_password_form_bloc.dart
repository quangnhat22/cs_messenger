import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/forgot_password_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

@Injectable()
class ForgotPasswordFormBloc extends FormBloc<String, String> {
  late final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordFormBloc(this._forgotPasswordUseCase) {
    addFieldBlocs(fieldBlocs: [
      email,
    ]);
  }

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      AppFormValidatorExt.validateEmail,
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  @override
  Future<void> onSubmitting() async {
    try {
      AppLoadingOverlayWidget.show();
      Future.delayed(const Duration(milliseconds: 500));
      //TODO: implement forgot password features
      //await _forgotPasswordUseCase.executeObj();
      AppLoadingOverlayWidget.dismiss();
      await getIt<AppRouter>()
          .push(SendEmailSuccessRoute(email: '123@gmail.com'));
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
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

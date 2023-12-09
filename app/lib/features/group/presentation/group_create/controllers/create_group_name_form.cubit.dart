import 'dart:async';

import 'package:app/configs/exts/app_exts.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateGroupNameFormBloc extends FormBloc<String, String> {
  CreateGroupNameFormBloc() {
    addFieldBlocs(fieldBlocs: [groupName]);
  }

  final groupName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  @override
  Future<void> onSubmitting() async {
    // try {
    //   AppLoadingOverlayWidget.show();
    //   emitSubmitting();
    //   await _updateUserProfileUseCase.executeObj(
    //       request: UpdateUserSelfParam(
    //     name: name.value,
    //     gender: gender.value?.value,
    //     phone: phone.value,
    //     birthday: DateTimeExt.convertDateTime2Timestamp(dateOfBirth.value),
    //     bio: bio.value,
    //   ));
    //   emitSuccess();
    //   AppLoadingOverlayWidget.dismiss();

    //   AppSnackBarWidget()
    //       .setLabelText(R.strings.updateProfileSuccess)
    //       .setAppSnackBarType(AppSnackBarType.informMessage)
    //       .setAppSnackBarStatus(AppSnackBarStatus.success)
    //       .showSnackBar();
    // } on AppException catch (e) {
    //   AppLoadingOverlayWidget.dismiss();
    //   AppExceptionExt(
    //       appException: e,
    //       onError: (_) {
    //         emitFailure();
    //         AppDefaultDialogWidget()
    //             .setTitle(R.strings.error)
    //             .setContent(R.strings.updateProfileFail)
    //             .setAppDialogType(AppDialogType.error)
    //             .setNegativeText(R.strings.close)
    //             .setPositiveText(R.strings.confirm)
    //             .buildDialog(AppKeys.navigatorKey.currentContext!)
    //             .show();
    //       }).detected();
    // }
  }
}

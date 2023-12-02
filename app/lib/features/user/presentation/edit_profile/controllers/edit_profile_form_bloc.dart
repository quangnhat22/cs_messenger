import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/exts/app_form_validator_ext.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_profile_uc.dart';
import 'package:app/features/user/domain/usecases/profile/update_user_profile_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class EditProfileFormBloc extends FormBloc<String, String> {
  late final UpdateUserProfileUseCase _updateUserProfileUseCase;
  late final GetUserProfileUseCase _getUserProfileUseCase;

  EditProfileFormBloc(
      this._updateUserProfileUseCase, this._getUserProfileUseCase) {
    addFieldBlocs(fieldBlocs: [name, phone, dateOfBirth, gender, bio]);
  }

  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final phone = TextFieldBloc(
    validators: [
      AppFormValidatorExt.validatePhoneNumber,
    ],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final dateOfBirth = InputFieldBloc<DateTime?, dynamic>(
    initialValue: null,
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final gender = SelectFieldBloc<GenderType, dynamic>(
    items: [GenderType.male, GenderType.female, GenderType.other],
    initialValue: GenderType.other,
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  final bio = TextFieldBloc(
    validators: [],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );

  Future<void> initPage() async {
    try {
      AppLoadingOverlayWidget.show();
      final response = await _getUserProfileUseCase.executeObj();
      final userInfo = response.netData;
      name.updateInitialValue(userInfo?.name ?? '');
      phone.updateInitialValue(userInfo?.phone ?? '');
      dateOfBirth.updateInitialValue(userInfo?.birthday);
      gender.updateInitialValue(userInfo?.gender);
      bio.updateInitialValue(userInfo?.bio ?? '');
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppExceptionExt(appException: e, onError: (_) {}).detected();
    }
  }

  @override
  Future<void> onSubmitting() async {
    try {
      AppLoadingOverlayWidget.show();
      emitSubmitting();
      await _updateUserProfileUseCase.executeObj(
          request: UpdateUserSelfParam(
        name: name.value,
        gender: gender.value?.value,
        phone: phone.value,
        birthday: DateTimeExt.convertDateTime2Timestamp(dateOfBirth.value),
        bio: bio.value,
      ));
      emitSuccess();
      AppLoadingOverlayWidget.dismiss();

      AppSnackBarWidget()
          .setLabelText(R.strings.updateProfileSuccess)
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
                .setContent(R.strings.updateProfileFail)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }
}

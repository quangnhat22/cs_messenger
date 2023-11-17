import 'dart:async';

import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/user/domain/usecases/get_user_profile_uc.dart';
import 'package:app/features/user/domain/usecases/update_user_profile_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

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
    validators: [],
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );
  final dateOfBirth = TextFieldBloc(
    validators: [],
    initialValue: '22/12/2002',
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );
  final gender = TextFieldBloc(
    validators: [],
    initialValue: 'Nam',
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );
  final bio = TextFieldBloc(
    validators: [],
    initialValue: 'Xin chào, tôi tên là Quang',
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
      dateOfBirth.updateInitialValue(userInfo?.birthday.toString() ?? '');
      gender.updateInitialValue(userInfo?.gender?.value ?? '');
      bio.updateInitialValue(userInfo?.bio ?? '');
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppExceptionExt(appException: e, onError: (_) {}).detected();
    }
  }

  @override
  Future<void> onSubmitting() async {}
}

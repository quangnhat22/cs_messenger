import 'dart:async';

import 'package:app/configs/exts/app_exts.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class EditProfileFormBloc extends FormBloc<String, String> {
  EditProfileFormBloc() {
    addFieldBlocs(fieldBlocs: [name, phone, dateOfBirth, gender, bio]);
  }

  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    initialValue: 'Nguyen Dinh Nhat Quang',
    asyncValidatorDebounceTime:
        const Duration(milliseconds: AppFormKeys.durationDebounceTime),
  );
  final phone = TextFieldBloc(
    validators: [],
    initialValue: '0367780567',
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

  @override
  Future<void> onSubmitting() async {}
}

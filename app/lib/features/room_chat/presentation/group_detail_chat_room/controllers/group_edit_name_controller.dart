import 'dart:async';

import 'package:app/configs/exts/app_exts.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GroupEditNameFormBloc extends FormBloc<String, String> {
  GroupEditNameFormBloc() {
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
  Future<void> onSubmitting() async {}
}

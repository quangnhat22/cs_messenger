import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SearchInputBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  SearchInputBloc() {
    addFieldBlocs(fieldBlocs: [
      email,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    throw UnimplementedError();
  }
}

import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/user/presentation/edit_profile/controllers/edit_profile_form_bloc.dart';
import 'package:app/features/user/presentation/edit_profile/widgets/edit_profile_select_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppTextFieldWidget()
            .setBloc(context.read<EditProfileFormBloc>().name)
            .setIsRequired(true)
            .setKeyboardType(TextInputType.text)
            .setAutoFillHints([AutofillHints.name])
            .setLabelText(R.strings.name)
            .setPrefixIcon(const Icon(Icons.person_outline))
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
        AppTextFieldWidget()
            .setBloc(context.read<EditProfileFormBloc>().phone)
            .setKeyboardType(TextInputType.phone)
            .setAutoFillHints([AutofillHints.telephoneNumber])
            .setLabelText(R.strings.phone)
            .setPrefixIcon(const Icon(Icons.phone_outlined))
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
        AppDatePickerWidget()
            .setInputBloc(context.read<EditProfileFormBloc>().dateOfBirth)
            .setPrefixIcon(const Icon(Icons.calendar_today))
            .setLabelText(R.strings.dateOfBirth)
            .setInitTime(DateTime.now())
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
        const EditProfileSelectGender(),
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
        AppTextFieldWidget()
            .setBloc(context.read<EditProfileFormBloc>().bio)
            .setKeyboardType(TextInputType.text)
            .setMaxLines(2)
            .setTextAlignVertical(TextAlignVertical.top)
            .setLabelText(R.strings.bio)
            .setPrefixIcon(const Icon(Icons.info_outlined))
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(6),
        ),
      ],
    );
  }
}

import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/setting/presentation/theme_and_language/widgets/radio_list_tile_widget.dart';
import 'package:app/features/user/presentation/edit_profile/controllers/edit_profile_form_bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';
import 'package:select_dialog/select_dialog.dart';

class EditProfileSelectGender extends StatelessWidget {
  const EditProfileSelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _open(context);
      },
      child: DropdownFieldBlocBuilder<GenderType>(
        selectFieldBloc: context.read<EditProfileFormBloc>().gender,
        isEnabled: false,
        textColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) =>
              Theme.of(context).colorScheme.onBackground,
        ),
        decoration: InputDecoration(
            labelText: R.strings.gender,
            prefixIcon: const Icon(Icons.transgender_outlined),
            contentPadding: EdgeInsets.all(
              AppSizeExt.of.majorPaddingScale(4),
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppSizeExt.of.majorScale(4),
                ),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppSizeExt.of.majorScale(4),
                ),
              ),
            )),
        itemBuilder: (context, value) => FieldItem(
          child: Text(GenderType.genderType2Label(value)),
        ),
      ),
    );
  }

  //TODO: radio need to common widget
  Future<void> _open(BuildContext context) async {
    final bloc = context.read<EditProfileFormBloc>().gender;

    await SelectDialog.showModal<GenderType>(
      context,
      label: R.strings.selectGender,
      titleStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      showSearchBox: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedValue: bloc.value,
      items: [GenderType.male, GenderType.female, GenderType.other],
      constraints: const BoxConstraints(maxHeight: 150),
      itemBuilder: (BuildContext context, GenderType item, bool isSelected) {
        return RadioListTileWidget(
          groupValue: bloc.value!,
          value: item,
          label: GenderType.genderType2Label(item),
          onChanged: (value) {
            bloc.changeValue(value);
            Navigator.of(context).pop();
          },
        );
      },
      onChange: bloc.updateValue,
    );
  }
}

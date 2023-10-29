import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_add_new_contact/controllers/search_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class AddNewContactCardSearchWidget extends StatelessWidget {
  const AddNewContactCardSearchWidget({super.key});

  void _handleSearchButtonPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizeExt.of.majorPaddingScale(3),
          vertical: AppSizeExt.of.majorPaddingScale(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
              child: AppTextTitleMediumWidget()
                  .setText(R.strings.searchFriend)
                  .setTextStyle(TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ))
                  .build(context),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: AppTextFieldWidget()
                      .setBloc(context.read<SearchInputBloc>().email)
                      .setDecoration(
                        InputDecoration(
                          labelText: R.strings.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                          contentPadding: EdgeInsets.all(
                            AppSizeExt.of.majorPaddingScale(3),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSizeExt.of.majorScale(8)),
                            ),
                          ),
                        ),
                      )
                      .build(context),
                ),
                SizedBox(width: AppSizeExt.of.majorScale(2)),
                AppButtonFilledWidget()
                    .setAppButtonType(AppButtonType.circle)
                    .setPrefixIcon(Icon(
                      Icons.search_outlined,
                      color: Theme.of(context).colorScheme.background,
                    ))
                    .setOnPressed(() => _handleSearchButtonPressed(context))
                    .build(context)
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/user/presentation/edit_profile/controllers/edit_profile_form_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileFormBloc>(),
      child: AppMainPageWidget()
          .setAppBar(_appBar(context))
          .setBackgroundColor(Theme.of(context).colorScheme.background)
          .setBody(_body(context))
          .build(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBarWidget()
        .setTextTitle(R.strings.editProfile)
        .setBackgroundColor(Colors.transparent)
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(5),
            horizontal: AppSizeExt.of.majorPaddingScale(5),
          ),
          child: Column(
            children: <Widget>[
              AppTextFieldWidget()
                  .setBloc(context.read<EditProfileFormBloc>().name)
                  .setKeyboardType(TextInputType.text)
                  .setAutoFillHints([AutofillHints.name])
                  .setDecoration(
                    InputDecoration(
                      labelText: R.strings.name,
                      prefixIcon: const Icon(Icons.person_outline),
                      contentPadding: EdgeInsets.all(
                        AppSizeExt.of.majorPaddingScale(4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSizeExt.of.majorScale(4),
                          ),
                        ),
                      ),
                    ),
                  )
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(2),
              ),
              AppTextFieldWidget()
                  .setBloc(context.read<EditProfileFormBloc>().phone)
                  .setKeyboardType(TextInputType.phone)
                  .setAutoFillHints([AutofillHints.telephoneNumber])
                  .setDecoration(
                    InputDecoration(
                      labelText: R.strings.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      contentPadding: EdgeInsets.all(
                        AppSizeExt.of.majorPaddingScale(4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSizeExt.of.majorScale(4),
                          ),
                        ),
                      ),
                    ),
                  )
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(2),
              ),
              AppTextFieldWidget()
                  .setBloc(context.read<EditProfileFormBloc>().dateOfBirth)
                  .setKeyboardType(TextInputType.datetime)
                  .setAutoFillHints([AutofillHints.birthday])
                  .setDecoration(
                    InputDecoration(
                      labelText: R.strings.dateOfBirth,
                      prefixIcon: const Icon(Icons.cake_outlined),
                      contentPadding: EdgeInsets.all(
                        AppSizeExt.of.majorPaddingScale(4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSizeExt.of.majorScale(4),
                          ),
                        ),
                      ),
                    ),
                  )
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(2),
              ),
              AppTextFieldWidget()
                  .setBloc(context.read<EditProfileFormBloc>().gender)
                  .setAutoFillHints([AutofillHints.gender])
                  .setDecoration(
                    InputDecoration(
                      labelText: R.strings.gender,
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      contentPadding: EdgeInsets.all(
                        AppSizeExt.of.majorPaddingScale(4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSizeExt.of.majorScale(4),
                          ),
                        ),
                      ),
                    ),
                  )
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(2),
              ),
              AppTextFieldWidget()
                  .setBloc(context.read<EditProfileFormBloc>().bio)
                  .setKeyboardType(TextInputType.text)
                  .setMaxLines(4)
                  .setTextAlignVertical(TextAlignVertical.top)
                  .setDecoration(
                    InputDecoration(
                      labelText: R.strings.bio,
                      prefixIcon: const Icon(Icons.info_outline),
                      contentPadding: EdgeInsets.all(
                        AppSizeExt.of.majorPaddingScale(4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSizeExt.of.majorScale(4),
                          ),
                        ),
                      ),
                    ),
                  )
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(6),
              ),
              AppButtonFilledWidget()
                  .setButtonText(R.strings.update.toUpperCase())
                  .setAppButtonSize(AppButtonSize.large)
                  .setBackgroundColor(
                      Theme.of(context).colorScheme.primaryContainer)
                  .setTextStyle(
                      TextStyle(color: Theme.of(context).colorScheme.primary))
                  .setOnPressed(() => {})
                  .build(context),
            ],
          ),
        ),
      );
    });
  }
}

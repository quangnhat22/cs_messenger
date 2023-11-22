import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/user/presentation/edit_profile/controllers/edit_profile_form_bloc.dart';
import 'package:app/features/user/presentation/edit_profile/widgets/edit_profile_form_widget.dart';
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
      create: (_) => getIt<EditProfileFormBloc>()..initPage(),
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
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizeExt.of.majorPaddingScale(5),
                    horizontal: AppSizeExt.of.majorPaddingScale(5),
                  ),
                  child: const EditProfileFormWidget(),
                ),
              ),
            ),
            Material(
              elevation: AppConstants.numberElevationContainer,
              child: Padding(
                padding: EdgeInsets.all(AppSizeExt.of.majorScale(4)),
                child: AppButtonFilledWidget()
                    .setButtonText(R.strings.update.toUpperCase())
                    .setAppButtonSize(AppButtonSize.large)
                    .setBackgroundColor(Theme.of(context).colorScheme.primary)
                    .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.background))
                    .setOnPressed(
                      () => context.read<EditProfileFormBloc>().submit(),
                    )
                    .build(context),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/features/setting/presentation/dashboard/controllers/cubit_setting_dashboard/setting_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class SettingShortUserInfo extends StatelessWidget {
  const SettingShortUserInfo({super.key});

  void _handleLogOutButton(BuildContext ctx) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.doYouWantToLogOut)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await ctx.read<SettingDashboardCubit>().logOut();
        })
        .buildDialog(ctx)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingDashboardCubit, SettingDashboardState>(
      builder: (context, state) {
        return AppCardBorderWidget()
            .setLeading(
              AppAvatarCircleWidget()
                  .setUrl(
                      'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg')
                  .setSize(AppAvatarSize.large)
                  .build(context),
            )
            .setTitle(AppTextTitleMediumWidget()
                .setText(state.userInfo?.name)
                .setMaxLines(3)
                .setTextOverFlow(TextOverflow.ellipsis)
                .build(context))
            .setSubtitle(AppTextBodySmallWidget()
                .setText(state.userInfo?.email)
                .setMaxLines(2)
                .setTextOverFlow(TextOverflow.ellipsis)
                .build(context))
            .setActions(<Widget>[
          AppButtonFilledWidget()
              .setAppButtonType(AppButtonType.circle)
              .setAppButtonSize(AppButtonSize.small)
              .setPrefixIcon(Icon(
                Icons.logout_outlined,
                color: Theme.of(context).colorScheme.error,
              ))
              .setOnPressed(() => _handleLogOutButton(context))
              .setBackgroundColor(Theme.of(context).colorScheme.errorContainer)
              .build(context)
        ]).build(context);
      },
    );
  }
}

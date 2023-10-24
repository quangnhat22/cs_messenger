import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class SettingShortUserInfo extends StatelessWidget {
  const SettingShortUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardBorderWidget()
        .setLeading(
          AppAvatarCircleWidget()
              .setUrl(
                  'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg')
              .setSize(AppAvatarSize.large)
              .build(context),
        )
        .setTitle(AppTextTitleMediumWidget()
            .setText('Nguyen Dinh Nhat Quang')
            .setMaxLines(3)
            .setTextOverFlow(TextOverflow.ellipsis)
            .build(context))
        .setSubtitle(AppTextBodySmallWidget()
            .setText('quangnguyen221202@gmail.com')
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
  }

  void _handleLogOutButton(BuildContext ctx) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.doYouWantToLogOut)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnNegative(() {})
        .setOnPositive(() {})
        .buildDialog(ctx)
        .show();
  }
}

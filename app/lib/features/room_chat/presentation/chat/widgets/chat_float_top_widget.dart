import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class ChatFloatTopWidget extends StatelessWidget {
  const ChatFloatTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppCardWidget()
              .setElevation(5)
              .setTitle(AppTextBodyMediumWidget()
                  .setText('Calling')
                  .setColor(Theme.of(context).colorScheme.onBackground)
                  .build(context))
              .setBackgroundColor(Colors.transparent)
              .setLeading(AppAvatarCircleWidget()
                  .setSize(AppAvatarSize.medium)
                  .setUrl('url')
                  .build(context))
              .setActions([
            AppButtonFilledWidget()
                .setButtonText(R.strings.join)
                .setOnPressed(() {})
                .setBackgroundColor(
                    Theme.of(context).colorScheme.tertiaryContainer)
                .build(context)
          ]).build(context),
        ],
      ),
    );
  }
}

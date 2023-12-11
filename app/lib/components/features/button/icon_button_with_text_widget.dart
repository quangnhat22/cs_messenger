import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IconButtonWithTextWidget extends StatelessWidget {
  const IconButtonWithTextWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppButtonFilledWidget()
            .setAppButtonSize(AppButtonSize.small)
            .setAppButtonType(AppButtonType.circle)
            .setPrefixIcon(icon)
            .build(context),
        SizedBox(
          height: AppSizeExt.of.majorScale(1),
        ),
        AppTextTitleMediumWidget()
            .setText(text)
            .setColor(Theme.of(context).colorScheme.primary)
            .build(context),
      ],
    );
  }
}

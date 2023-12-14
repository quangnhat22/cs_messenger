import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IconButtonWithTextWidget extends StatelessWidget {
  const IconButtonWithTextWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final Widget icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.medium)
              .setBackgroundColor(
                  Theme.of(context).colorScheme.primaryContainer)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(icon)
              .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(2),
          ),
          AppTextTitleMediumWidget()
              .setText(text)
              .setColor(Theme.of(context).colorScheme.primary)
              .build(context),
        ],
      ),
    );
  }
}

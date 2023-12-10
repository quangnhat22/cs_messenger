import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class GroupListLabelWidget extends StatelessWidget {
  const GroupListLabelWidget({super.key, this.total = 0});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(3),
        vertical: AppSizeExt.of.majorPaddingScale(2),
      ),
      child: AppTextTitleMediumWidget()
          .setText("${R.strings.groups} (${total.toString()})")
          .setTextStyle(TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ))
          .build(context),
    );
  }
}

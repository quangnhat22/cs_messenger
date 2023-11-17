import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RadioListTileWidget extends StatelessWidget {
  const RadioListTileWidget({
    Key? key,
    this.label,
    this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String? label;
  final EdgeInsets? padding;
  final String groupValue;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCardBorderWidget()
        .setTitle(AppTextBodyLargeWidget().setText(label).build(context))
        .setContentPadding(
          EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(2 / 4),
            horizontal: AppSizeExt.of.majorPaddingScale(2),
          ),
        )
        .setActions(
      [
        Radio(
          groupValue: groupValue,
          value: value,
          onChanged: (newValue) {
            onChanged(newValue!);
          },
        ),
      ],
    ).build(context);
  }
}

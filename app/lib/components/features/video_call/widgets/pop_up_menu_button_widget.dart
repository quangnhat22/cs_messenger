import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PopUpMenuItemButtonWidget extends StatelessWidget {
  const PopUpMenuItemButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor,
  });

  final String label;
  final IconData icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        child: Icon(
          icon,
          size: AppSizeExt.of.majorScale(5),
          color: Colors.white,
        ),
      ),
      title: AppTextBodyMediumWidget().setText(label).build(context),
    );
  }
}

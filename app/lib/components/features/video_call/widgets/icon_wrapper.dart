import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class IconWrapper extends StatelessWidget {
  const IconWrapper({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.onPressed,
  });

  final Widget icon;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? Colors.black45,
      radius: AppSizeExt.of.majorScale(6),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}

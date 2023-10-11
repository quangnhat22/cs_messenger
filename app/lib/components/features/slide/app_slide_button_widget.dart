import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppSlideButtonStyle { nextStyle, backStyle }

class AppSlideButtonWidget extends StatelessWidget {
  const AppSlideButtonWidget({
    super.key,
    required this.text,
    this.styleButton = AppSlideButtonStyle.nextStyle,
    this.onTab,
    this.isVisible = true,
  });

  final String text;
  final AppSlideButtonStyle styleButton;
  final void Function()? onTab;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final (:textColor, :backgroundColor, :borderRadius, :padding) =
        _configStyle(context);

    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: onTab,
        borderRadius: borderRadius,
        child: Ink(
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          padding: padding,
          child: AppTextTitleLargeWidget()
              .setText(text)
              .setColor(textColor)
              .build(context),
        ),
      ),
    );
  }

  ({
    Color textColor,
    Color backgroundColor,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding
  }) _configStyle(BuildContext context) {
    return styleButton == AppSlideButtonStyle.nextStyle
        ? (
            textColor: Theme.of(context).colorScheme.surface,
            backgroundColor: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizeExt.of.majorScale(20)),
              bottomLeft: Radius.circular(AppSizeExt.of.majorScale(20)),
            ),
            padding: EdgeInsets.only(
              left: AppSizeExt.of.majorPaddingScale(5),
              top: AppSizeExt.of.majorPaddingScale(3),
              bottom: AppSizeExt.of.majorPaddingScale(3),
              right: AppSizeExt.of.majorPaddingScale(2),
            ),
          )
        : (
            textColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSizeExt.of.majorScale(20)),
              bottomRight: Radius.circular(AppSizeExt.of.majorScale(20)),
            ),
            padding: EdgeInsets.only(
              right: AppSizeExt.of.majorPaddingScale(5),
              top: AppSizeExt.of.majorPaddingScale(3),
              bottom: AppSizeExt.of.majorPaddingScale(3),
              left: AppSizeExt.of.majorPaddingScale(2),
            )
          );
  }
}

import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class FormCardLayout extends StatelessWidget {
  const FormCardLayout({
    super.key,
    required this.title,
    required this.subTitle,
    this.backgroundColor,
    this.textColor,
    this.formWidget,
  });

  final String title;
  final String subTitle;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? formWidget;

  void _handleBackButton(BuildContext ctx) async {
    await ctx.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          _buildBackWidget(context),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 0.7 * screenSize.height,
            child: _buildTopWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBackWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppSizeExt.of.majorPaddingScale(30 / 4),
        left: AppSizeExt.of.majorPaddingScale(3),
        right: AppSizeExt.of.majorPaddingScale(3),
      ),
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: EdgeInsets.only(left: AppSizeExt.of.majorScale(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppButtonFilledWidget()
                .setAppButtonType(AppButtonType.circle)
                .setPrefixIcon(Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).colorScheme.primary,
                ))
                .setBackgroundColor(Theme.of(context).colorScheme.background)
                .setOnPressed(() => _handleBackButton(context))
                .build(context),
            SizedBox(height: AppSizeExt.of.majorPaddingScale(3)),
            AppTextHeadlineLargeWidget()
                .setText(title)
                .setTextStyle(TextStyle(color: textColor))
                .build(context),
            SizedBox(height: AppSizeExt.of.majorPaddingScale(3)),
            AppTextTitleSmallWidget()
                .setText(subTitle)
                .setTextStyle(TextStyle(color: textColor))
                .build(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(7),
        horizontal: AppSizeExt.of.majorPaddingScale(7),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(10)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(10)),
        ),
      ),
      child: formWidget,
    );
  }
}

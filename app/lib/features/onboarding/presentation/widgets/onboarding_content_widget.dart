import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/exts/app_constants_ext.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    super.key,
    required this.mainImage,
    required this.title,
    required this.subtitle,
  });

  final Widget mainImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(1),
            horizontal: AppSizeExt.of.majorPaddingScale(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppTextHeadlineLargeWidget()
                  .setText(AppConstants.appName)
                  .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                  )
                  .build(context),
              SizedBox(height: AppSizeExt.of.majorScale(12)),
              mainImage,
              SizedBox(height: AppSizeExt.of.majorScale(8)),
              AppTextHeadlineMediumWidget()
                  .setText(title)
                  .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                  )
                  .setTextAlign(TextAlign.center)
                  .build(context),
              SizedBox(height: AppSizeExt.of.majorScale(5)),
              AppTextBodyMediumWidget()
                  .setText(subtitle)
                  .setTextAlign(TextAlign.center)
                  .build(context),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppNoticeFullScreenWidget extends StatelessWidget {
  const AppNoticeFullScreenWidget({
    super.key,
    required this.image,
    this.title,
    this.subTitle,
    this.subWidget,
    this.actions,
    this.backgroundColor,
  });

  final Image image;
  final String? title;
  final String? subTitle;
  final Widget? subWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppStackPageWidget()
        .setShowCircleBackgroundWidget(true)
        .setBackgroundColorCircle(backgroundColor?.withOpacity(0.2))
        .setBackgroundColor(Theme.of(context).colorScheme.background)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    image,
                    SizedBox(
                      height: AppSizeExt.of.majorScale(5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizeExt.of.majorPaddingScale(4),
                        vertical: AppSizeExt.of.majorPaddingScale(3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppTextDisplaySmallWidget()
                              .setText(title)
                              .setColor(backgroundColor)
                              .setTextAlign(TextAlign.center)
                              .build(context),
                          SizedBox(
                            height: AppSizeExt.of.majorScale(5),
                          ),
                          AppTextBodyMediumWidget()
                              .setText(subTitle)
                              .setTextAlign(TextAlign.center)
                              .build(context),
                          if (subWidget != null)
                            SizedBox(
                              height: AppSizeExt.of.majorScale(6),
                            ),
                          subWidget ?? const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (actions != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!,
            ),
        ],
      ),
    );
  }
}

import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/notification/notification_setting/widgets/notification_switch_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class NotificationSettingPage extends StatelessWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(
            AppBarWidget().setTextTitle(R.strings.notification).build(context))
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(4),
            horizontal: AppSizeExt.of.majorPaddingScale(2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //theme
              Card(
                surfaceTintColor: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppTextTitleLargeWidget()
                          .setText(R.strings.turnOnOffNotification)
                          .setColor(Theme.of(context).colorScheme.primary)
                          .build(context),
                      SizedBox(height: AppSizeExt.of.majorScale(3)),
                      const NotificationSwitchWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

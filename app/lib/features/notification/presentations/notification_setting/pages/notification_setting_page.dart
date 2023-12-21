import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/notification/presentations/notification_setting/controllers/notification_setting_cubit.dart';
import 'package:app/features/notification/presentations/notification_setting/widgets/notification_switch_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class NotificationSettingPage extends StatelessWidget {
  const NotificationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationSettingCubit>(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.notification)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
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
                elevation: 0,
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
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

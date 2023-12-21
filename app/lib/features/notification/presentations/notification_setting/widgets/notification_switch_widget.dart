import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/notification/presentations/notification_setting/controllers/notification_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class NotificationSwitchWidget extends StatelessWidget {
  const NotificationSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingCubit, NotificationSettingState>(
      buildWhen: (prev, current) =>
          prev.isTurnNotificationOn != current.isTurnNotificationOn,
      builder: (context, state) {
        return AppCardBorderWidget()
            .setTitle(AppTextBodyLargeWidget()
                .setText(R.strings.notification)
                .build(context))
            .setContentPadding(
              EdgeInsets.symmetric(
                vertical: AppSizeExt.of.majorPaddingScale(2 / 4),
                horizontal: AppSizeExt.of.majorPaddingScale(2),
              ),
            )
            .setActions(
          [
            Switch(
              value: state.isTurnNotificationOn,
              onChanged: (bool value) {
                context
                    .read<NotificationSettingCubit>()
                    .onChangeNotificationStatus(value);
              },
            )
          ],
        ).build(context);
      },
    );
  }
}

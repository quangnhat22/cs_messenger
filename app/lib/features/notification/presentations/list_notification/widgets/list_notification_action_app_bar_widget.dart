import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/features/notification/presentations/list_notification/controller/list_notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';

class ListNotificationActionAppBarWidget extends StatelessWidget {
  const ListNotificationActionAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => _handleDeleteAllNotification(context),
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }

  void _handleDeleteAllNotification(BuildContext context) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.confirm)
        .setContent(R.strings.doYouWantToDeleteAllNotifications)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await context.read<ListNotificationCubit>().deleteAllNotifications();
        })
        .buildDialog(context)
        .show();
  }
}

import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/notification/presentations/list_notification/controller/list_notification_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class ListNotificationWidget extends StatelessWidget {
  const ListNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<NotificationModel, AppListViewState<NotificationModel>,
        ListNotificationCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardNotificationItem,
    );
  }

  Widget _buildCardNotificationItem(
      BuildContext context, NotificationModel notification, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(1),
        horizontal: AppSizeExt.of.majorPaddingScale(1),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext ctx) =>
                  _handleDeleteNotification(context, notification.id ?? ''),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              icon: Icons.delete,
              label: R.strings.deleteNotification,
              borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
              spacing: AppSizeExt.of.majorScale(2),
            ),
          ],
        ),
        child: AppCardWidget()
            .setLeading(AppAvatarCircleWidget()
                .setUrl(notification.details?.subject?.image)
                .setSize(AppAvatarSize.medium)
                .build(context))
            .setTitle(AppTextTitleMediumWidget()
                .setText(notification.heading)
                .build(context))
            .setSubtitle(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextBodyMediumWidget()
                      .setText(notification.content)
                      .build(context),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(1),
                  ),
                  AppTextBodySmallWidget()
                      .setText(DateTimeExt.dateTimeToDisplayHHmmddMMyyyy(
                          dateTime: notification.details?.createdAt))
                      .setTextStyle(
                        TextStyle(color: Theme.of(context).colorScheme.outline),
                      )
                      .build(context),
                ],
              ),
            )

            // .setActions([
            //   IconButton(
            //     onPressed: () async {
            //       if (friend.relation?.roomId != null) {
            //         await getIt<AppRouter>()
            //             .push(ChatRoute(roomId: friend.relation!.roomId!));
            //       }
            //     },
            //     icon: const Icon(Icons.message_outlined),
            //   )
            // ])
            .setOnTap(() async {
          // await getIt<AppRouter>()
          //     .push(FriendInfoRoute(userId: friend.id))
          //     .then((result) {
          //   Logs.d(result);
          //   if (result == true) {
          //     context.read<GetListFriendCubit>().onRefreshCall();
          //   }
          // });
        }).build(context),
      ),
    );
  }

  void _handleDeleteNotification(BuildContext context, String notificationId) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.confirm)
        .setContent(R.strings.doYouWantToDeleteThisNotification)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await context
              .read<ListNotificationCubit>()
              .deleteNotificationById(notificationId);
        })
        .buildDialog(context)
        .show();
  }
}

import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_friend_request_action/friend_request_action_cubit.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_sent_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class FriendSentRequestView extends StatelessWidget {
  const FriendSentRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
      child: AppListWidget<RequestModel, AppListViewState<RequestModel>,
          ListFriendSentRequestCubit>(
        physics: const BouncingScrollPhysics(),
        childWidget: _buildCardMissionItem,
      ),
    );
  }

  Widget _buildCardMissionItem(
      BuildContext context, RequestModel request, int index) {
    return AppCardWidget()
        .setElevation(1)
        .setLeading(AppAvatarCircleWidget()
            .setUrl(request.receiver?.avatar)
            .setSize(AppAvatarSize.large)
            .build(context))
        .setTitle(AppTextTitleMediumWidget()
            .setText(request.receiver?.name)
            .build(context))
        .setSubtitle(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextBodyMediumWidget()
                  .setText('${R.strings.email}: ${request.receiver?.email}')
                  .build(context),
              AppTextBodyMediumWidget()
                  .setText(
                      '${R.strings.sent}: ${DateTimeExt.dateTimeToDisplay(dateTime: request.createdAt)}')
                  .build(context),
            ],
          ),
        )
        .setActions([
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setBackgroundColor(Theme.of(context).colorScheme.primary)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.undo_outlined,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(() async =>
                  await _handleUndoRequestButton(context, request.id))
              .build(context),
        ])
        .setOnTap(
            () => _showDetailFriendReceiveReceive(context, request: request))
        .build(context);
  }

  Future<void> _handleUndoRequestButton(
      BuildContext context, String requestId) async {
    try {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.confirm)
          .setTitle(R.strings.confirm)
          .setContent(R.strings.doYouWantUndoFriendRequest)
          .setNegativeText(R.strings.close)
          .setPositiveText(R.strings.confirm)
          .setOnPositive(() async {
            await context
                .read<FriendRequestActionCubit>()
                .undoRequest(requestId);
            if (context.mounted) {
              await context.read<ListFriendSentRequestCubit>().onRefreshCall();
            }
          })
          .buildDialog(context)
          .show();
    } catch (e) {
      Logs.e(e.toString());
    }
  }

  void _showDetailFriendReceiveReceive(BuildContext context,
      {RequestModel? request}) {
    AppDialogRequestWidget()
        .setIsHaveCloseIcon(true)
        .setTopWidget(AppTextHeadlineMediumWidget()
            .setText(R.strings.friendRequest)
            .setTextStyle(TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ))
            .build(context))
        .setContentWidget(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: AppSizeExt.of.majorScale(4),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizeExt.of.majorPaddingScale(3),
                vertical: AppSizeExt.of.majorPaddingScale(3),
              ),
              child: Row(
                children: [
                  AppTextTitleMediumWidget()
                      .setText('${R.strings.sent} ')
                      .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ))
                      .build(context),
                  SizedBox(
                    width: AppSizeExt.of.majorScale(2),
                  ),
                  AppTextTitleMediumWidget()
                      .setText(DateTimeExt.dateTimeToDisplayHHmmddMMyyyy(
                          dateTime: request?.createdAt))
                      .setTextStyle(
                          const TextStyle(fontStyle: FontStyle.italic))
                      .build(context),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizeExt.of.majorPaddingScale(3),
                vertical: AppSizeExt.of.majorPaddingScale(3),
              ),
              child: AppTextTitleMediumWidget()
                  .setText(R.strings.receiver)
                  .setTextStyle(TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ))
                  .build(context),
            ),
            AppCardWidget()
                .setElevation(0)
                .setLeading(
                  AppAvatarCircleWidget()
                      .setUrl(request?.receiver?.avatar)
                      .setSize(AppAvatarSize.mediumLarge)
                      .build(context),
                )
                .setTitle(
                  AppTextTitleMediumWidget()
                      .setText(request?.receiver?.name)
                      .build(context),
                )
                .setSubtitle(
                  AppTextBodySmallWidget()
                      .setText('${request?.receiver?.email}')
                      .setMaxLines(2)
                      .build(context),
                )
                .setOnTap(() async {
              if (request?.sender?.id != null) {
                await getIt<AppRouter>().pop();
                await getIt<AppRouter>()
                    .push(FriendInfoRoute(userId: request!.receiver!.id));
              }
            }).setActions([const Icon(Icons.chevron_right)]).build(context)
          ],
        ))
        .buildDialog(context)
        .show();
  }
}

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
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_received_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class FriendReceivedRequestView extends StatelessWidget {
  const FriendReceivedRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
      child: AppListWidget<RequestModel, AppListViewState<RequestModel>,
          ListFriendReceivedRequestCubit>(
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
            .setUrl(request.sender?.avatar)
            .setSize(AppAvatarSize.large)
            .build(context))
        .setTitle(AppTextTitleMediumWidget()
            .setText(request.sender?.name)
            .build(context))
        .setSubtitle(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextBodyMediumWidget()
                  .setText('${R.strings.email}: ${request.sender?.email}')
                  .setMaxLines(2)
                  .build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(1),
              ),
              AppTextBodyMediumWidget()
                  .setText(
                      '${R.strings.receive}: ${DateTimeExt.dateTimeToDisplay(dateTime: request.createdAt)}')
                  .build(context),
            ],
          ),
        )
        .setActions([
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setBackgroundColor(Theme.of(context).colorScheme.tertiary)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.close_outlined,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(() async =>
                  await _handleRejectRequestButton(context, request.id))
              .build(context),
          SizedBox(
            width: AppSizeExt.of.majorScale(2),
          ),
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.done_outline,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(() async =>
                  await _handleAcceptRequestButton(context, request.id))
              .build(context),
        ])
        .setOnTap(
            () => _showDetailFriendRequestReceive(context, request: request))
        .build(context);
  }

  Future<void> _handleRejectRequestButton(
      BuildContext context, String requestId) async {
    try {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.confirm)
          .setTitle(R.strings.confirm)
          .setContent(R.strings.doYouWantRejectFriendRequest)
          .setNegativeText(R.strings.close)
          .setPositiveText(R.strings.confirm)
          .setOnPositive(() async {
            await context
                .read<FriendRequestActionCubit>()
                .rejectRequest(requestId);
            if (context.mounted) {
              await context
                  .read<ListFriendReceivedRequestCubit>()
                  .onRefreshCall();
            }
          })
          .buildDialog(context)
          .show();
    } catch (e) {
      Logs.e(e.toString());
    }
  }

  Future<void> _handleAcceptRequestButton(
      BuildContext context, String requestId) async {
    try {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.confirm)
          .setTitle(R.strings.confirm)
          .setContent(R.strings.doYouWantAcceptFriendRequest)
          .setNegativeText(R.strings.close)
          .setPositiveText(R.strings.confirm)
          .setOnPositive(() async {
            await context
                .read<FriendRequestActionCubit>()
                .acceptRequest(requestId);
            if (context.mounted) {
              await context
                  .read<ListFriendReceivedRequestCubit>()
                  .onRefreshCall();
            }
          })
          .buildDialog(context)
          .show();
    } catch (e) {
      Logs.e(e.toString());
    }
  }

  void _showDetailFriendRequestReceive(BuildContext context,
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
                  .setText(R.strings.sender)
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
                      .setUrl(request?.sender?.avatar)
                      .setSize(AppAvatarSize.mediumLarge)
                      .build(context),
                )
                .setTitle(
                  AppTextTitleMediumWidget()
                      .setText(request?.sender?.name)
                      .build(context),
                )
                .setSubtitle(
                  AppTextBodySmallWidget()
                      .setText('${request?.sender?.email}')
                      .setMaxLines(2)
                      .build(context),
                )
                .setOnTap(() async {
              if (request?.sender?.id != null) {
                await getIt<AppRouter>().pop();
                await getIt<AppRouter>()
                    .push(FriendInfoRoute(userId: request!.sender!.id));
              }
            }).setActions([const Icon(Icons.chevron_right)]).build(context)
          ],
        ))
        .buildDialog(context)
        .show();
  }
}

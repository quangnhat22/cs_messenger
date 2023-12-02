import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
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
        emptyView: const SizedBox(),
        retryView: const SizedBox(),
      ),
    );
  }

  Widget _buildCardMissionItem(
      BuildContext context, RequestModel request, int index) {
    return AppCardWidget()
        .setElevation(1)
        .setLeading(const CircleAvatar(radius: 24))
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
              .setBackgroundColor(Theme.of(context).colorScheme.tertiary)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.close_outlined,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(
                  () => _handleRejectRequestButton(context, request.id))
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
              .setOnPressed(
                  () => _handleAcceptRequestButton(context, request.id))
              .build(context),
        ])
        .setOnTap(() {})
        .build(context);
  }

  Future<void> _handleRejectRequestButton(
      BuildContext context, String requestId) async {
    try {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.confirm)
          .setContent(R.strings.doYouWantRejectFriendRequest)
          .setNegativeText(R.strings.close)
          .setPositiveText(R.strings.confirm)
          .setOnPositive(() async {
            await context
                .read<FriendRequestActionCubit>()
                .rejectRequest(requestId);
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
          .setContent(R.strings.doYouWantAcceptFriendRequest)
          .setNegativeText(R.strings.close)
          .setPositiveText(R.strings.confirm)
          .setOnPositive(() async {
            await context
                .read<FriendRequestActionCubit>()
                .acceptRequest(requestId);
          })
          .buildDialog(context)
          .show();
    } catch (e) {
      Logs.e(e.toString());
    }
  }
}

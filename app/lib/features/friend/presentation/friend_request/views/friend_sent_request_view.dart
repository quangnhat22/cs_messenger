import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
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
        emptyView: const SizedBox(),
        retryView: const SizedBox(),
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
        .setOnTap(() {})
        .build(context);
  }

  Future<void> _handleUndoRequestButton(
      BuildContext context, String requestId) async {
    try {
      AppDefaultDialogWidget()
          .setAppDialogType(AppDialogType.confirm)
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
}

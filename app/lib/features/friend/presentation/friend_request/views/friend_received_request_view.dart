import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_received_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

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
        .setLeading(const CircleAvatar(radius: 24))
        .setTitle(AppTextTitleMediumWidget()
            .setText(request.sender?.name)
            .build(context))
        .setSubtitle(AppTextBodyMediumWidget()
            .setText('Receive: 10/11/2023')
            .build(context))
        .setActions([
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setBackgroundColor(Theme.of(context).colorScheme.tertiary)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.close_outlined,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(() {})
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
              .setOnPressed(() {})
              .build(context),
        ])
        .setOnTap(() {})
        .build(context);
  }
}

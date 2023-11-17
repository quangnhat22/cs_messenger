import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_sent_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

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
        .setLeading(const CircleAvatar(radius: 24))
        .setTitle(AppTextTitleMediumWidget().setText('Dinh Loc').build(context))
        .setSubtitle(AppTextBodyMediumWidget()
            .setText('Sent: 11/11/2023')
            .build(context))
        .setActions([
          AppButtonFilledWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setBackgroundColor(Theme.of(context).colorScheme.primary)
              .setAppButtonType(AppButtonType.circle)
              .setPrefixIcon(Icon(
                Icons.undo_outlined,
                color: Theme.of(context).colorScheme.background,
              ))
              .setOnPressed(() {})
              .build(context),
        ])
        .setOnTap(() {})
        .build(context);
  }
}

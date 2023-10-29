import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_calls/controllers/cubit_list_history_call/list_call_history_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class FriendCallListCallHistoryWidget extends StatelessWidget {
  const FriendCallListCallHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<HistoryCallModel, AppListViewState<HistoryCallModel>,
        ListCallHistoryCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardMissionItem,
      emptyView: const SizedBox(),
      retryView: const SizedBox(),
    );
  }

  Widget _buildCardMissionItem(
      BuildContext context, HistoryCallModel mission, int index) {
    return AppCardBorderWidget()
        .setLeading(const CircleAvatar(radius: 24))
        .setTitle(
            AppTextTitleMediumWidget().setText('Nguyen Van A').build(context))
        .setSubtitle(
          Row(
            children: [
              R.svgs.icOngoing.svg(),
              SizedBox(
                width: AppSizeExt.of.majorScale(2),
              ),
              AppTextBodyMediumWidget()
                  .setText('22/09/2023 - 11:30')
                  .build(context)
            ],
          ),
        )
        .setHasTopBorderRadius(index == 0)
        .setHasBottomBorderRadius(index == 99)
        .setActions([
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone_outlined),
          )
        ])
        .setIsShowBottomDivider(true)
        .setOnTap(() {})
        .build(context);
  }
}

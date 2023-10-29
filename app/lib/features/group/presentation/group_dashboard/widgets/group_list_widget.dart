import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_dashboard/controllers/cubit_list_group.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSizeExt.of.majorPaddingScale(1),
          horizontal: AppSizeExt.of.majorPaddingScale(1),
        ),
        child: AppListWidget<GroupModel, AppListViewState<GroupModel>,
            ListGroupCubit>(
          physics: const BouncingScrollPhysics(),
          childWidget: _buildCardGroupItem,
          emptyView: const SizedBox(),
          retryView: const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildCardGroupItem(
      BuildContext context, GroupModel group, int index) {
    return AppCardBorderWidget()
        .setLeading(const CircleAvatar(radius: 24))
        .setTitle(AppTextTitleMediumWidget().setText(group.name).build(context))
        // .setSubtitle(
        //   Row(
        //     children: [
        //       R.svgs.icOngoing.svg(),
        //       SizedBox(
        //         width: AppSizeExt.of.majorScale(2),
        //       ),
        //       AppTextBodyMediumWidget()
        //           .setText('22/09/2023 - 11:30')
        //           .build(context)
        //     ],
        //   ),
        // )
        .setHasTopBorderRadius(index == 0)
        .setHasBottomBorderRadius(index == 99)
        // .setActions([
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.phone_outlined),
        //   )
        // ])
        .setIsShowBottomDivider(false)
        .setOnTap(() {})
        .build(context);
  }
}

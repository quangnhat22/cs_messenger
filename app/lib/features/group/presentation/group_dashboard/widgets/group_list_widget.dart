import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
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
        ),
      ),
    );
  }

  Widget _buildCardGroupItem(
      BuildContext context, GroupModel group, int index) {
    return AppCardBorderWidget()
        .setLeading(AppAvatarCircleWidget()
            .setSize(AppAvatarSize.medium)
            .setUrl(group.avatar)
            .build(context))
        .setTitle(AppTextTitleMediumWidget().setText(group.name).build(context))
        .setHasTopBorderRadius(index == 0)
        .setHasBottomBorderRadius(index == 99)
        .setActions([
          IconButton(
            onPressed: () {
              getIt<AppRouter>().push(ChatRoute(roomId: group.roomId));
            },
            icon: const Icon(Icons.message_outlined),
          )
        ])
        .setIsShowBottomDivider(true)
        .setOnTap(() {})
        .build(context);
  }
}

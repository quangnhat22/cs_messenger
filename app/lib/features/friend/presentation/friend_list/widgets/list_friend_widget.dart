import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/features/friend/presentation/friend_list/controllers/friend_list_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

//TODO: refactor code
class ListFriendWidget extends StatelessWidget {
  const ListFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<UserModel, AppListViewState<UserModel>,
        GetListFriendCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardFriendItem,
      emptyView: const SizedBox(),
      retryView: const SizedBox(),
    );
  }

  Widget _buildCardFriendItem(
      BuildContext context, UserModel friend, int index) {
    return AppCardBorderWidget()
        .setLeading(const CircleAvatar(radius: 24))
        .setTitle(
            AppTextTitleMediumWidget().setText(friend.name).build(context))
        .setSubtitle(AppTextBodyMediumWidget()
            .setText("${R.strings.email}: ${friend.email}")
            .build(context))
        .setHasTopBorderRadius(index == 0)
        .setHasBottomBorderRadius(index == 99)
        .setActions([
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          )
        ])
        .setIsShowBottomDivider(true)
        .setOnTap(() {})
        .build(context);
  }
}

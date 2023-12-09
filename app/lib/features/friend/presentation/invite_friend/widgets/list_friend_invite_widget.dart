import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/features/friend/presentation/invite_friend/controllers/cubit/list_selected_friend_cubit.dart';
import 'package:app/features/friend/presentation/invite_friend/controllers/invite_list_friend_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class ListFriendInviteWidget extends StatelessWidget {
  const ListFriendInviteWidget({super.key, required this.listFriendSelected});

  final List<UserModel> listFriendSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // TextField(
          //   textAlignVertical: TextAlignVertical.center,
          //   decoration: InputDecoration(
          //     isCollapsed: true,
          //     hintText: R.strings.search,
          //     alignLabelWithHint: true,
          //     prefixIcon: const Icon(Icons.search),
          //     filled: true,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(AppSizeExt.of.majorScale(8)),
          //       ),
          //       borderSide: const BorderSide(
          //         width: 0,
          //         style: BorderStyle.none,
          //       ),
          //     ),
          //   ),
          //   onChanged: (value) {},
          // ),
          Expanded(
            child: AppListWidget<UserModel, AppListViewState<UserModel>,
                InviteListFriendCubit>(
              physics: const BouncingScrollPhysics(),
              childWidget: (context, friend, index) => _buildCardFriendItem(
                  context, friend, index, listFriendSelected),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardFriendItem(BuildContext context, UserModel friend, int index,
      List<UserModel> selectedMember) {
    return CheckboxListTile(
      title: AppTextTitleMediumWidget().setText(friend.name).build(context),
      subtitle: AppTextBodyMediumWidget()
          .setText("${R.strings.email}: ${friend.email}")
          .build(context),
      secondary: AppAvatarCircleWidget()
          .setUrl(friend.avatar)
          .setSize(AppAvatarSize.medium)
          .build(context),
      value: selectedMember
              .firstWhere(
                (element) => element.id == friend.id,
                orElse: () => UserModel.empty,
              )
              .id !=
          UserModel.empty.id,
      onChanged: (bool? value) => {
        context.read<ListSelectedFriendCubit>().selectedMemberChanged(friend)
      },
    );
  }
}

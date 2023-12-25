import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_list/controllers/friend_list_cubit.dart';
import 'package:app/features/friend/presentation/invite_friend/pages/inivite_friend_page.dart';
import 'package:app/features/group/presentation/group_member/controllers/group_list_member_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupMemberPage extends StatelessWidget {
  const GroupMemberPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GroupListMemberCubit>()..initPage(groupId),
      child: AppMainPageWidget()
          .setAppBar(
              AppBarWidget().setTextTitle(R.strings.members).build(context))
          .setBody(_body(context))
          .setFloatActionButton(_fabAddMemberButton(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return AppListWidget<UserModel, AppListViewState<UserModel>,
        GroupListMemberCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardFriendItem,
    );
  }

  Widget _buildCardFriendItem(
      BuildContext context, UserModel friend, int index) {
    return AppCardBorderWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(friend.avatar)
            .setSize(AppAvatarSize.medium)
            .build(context))
        .setTitle(
            AppTextTitleMediumWidget().setText(friend.name).build(context))
        .setSubtitle(
            AppTextBodyMediumWidget().setText("${friend.email}").build(context))
        .setHasTopBorderRadius(index == 0)
        .setActions([
          IconButton(
            onPressed: () async {
              if (friend.relation?.roomId != null) {
                await getIt<AppRouter>()
                    .push(ChatRoute(roomId: friend.relation!.roomId!));
              }
            },
            icon: const Icon(Icons.message_outlined),
          )
        ])
        .setIsShowBottomDivider(true)
        .setOnTap(() async {
          await getIt<AppRouter>()
              .push(FriendInfoRoute(userId: friend.id))
              .then((result) {
            if (result == true) {
              context.read<GetListFriendCubit>().onRefreshCall();
            }
          });
        })
        .build(context);
  }

  Widget _fabAddMemberButton(BuildContext context) {
    return BlocBuilder<GroupListMemberCubit, AppListViewState<UserModel>>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            bottom: AppSizeExt.of.majorScale(5),
          ),
          child: FloatingActionButton(
            onPressed: () async =>
                await _showBottomSheetAddMember(context, state.data),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _showBottomSheetAddMember(
      BuildContext context, List<UserModel> filterMember) async {
    await showModalBottomSheet<List<UserModel>>(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: context,
      builder: (context) {
        return InviteFriendPage(listFilterFriend: filterMember);
      },
    ).then((result) async {
      if (result != null && context.mounted) {
        await context.read<GroupListMemberCubit>().inviteMember(result);
      }
    });
  }
}

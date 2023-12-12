import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/friend/presentation/friend_list/controllers/friend_list_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class ListFriendWidget extends StatelessWidget {
  const ListFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<UserModel, AppListViewState<UserModel>,
        GetListFriendCubit>(
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
        .setSubtitle(AppTextBodyMediumWidget()
            .setText("${R.strings.email}: ${friend.email}")
            .build(context))
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
            Logs.d(result);
            if (result == true) {
              context.read<GetListFriendCubit>().onRefreshCall();
            }
          });
        })
        .build(context);
  }
}

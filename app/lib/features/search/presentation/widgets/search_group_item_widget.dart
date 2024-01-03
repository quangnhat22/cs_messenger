import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class SearchGroupItemWidget extends StatelessWidget {
  const SearchGroupItemWidget({
    super.key,
    this.group,
  });

  final GroupModel? group;

  @override
  Widget build(BuildContext context) {
    return AppCardBorderWidget()
        .setLeading(AppAvatarCircleWidget()
            .setSize(AppAvatarSize.medium)
            .setUrl(group?.avatar)
            .build(context))
        .setTitle(
            AppTextTitleMediumWidget().setText(group?.name).build(context))
        .setActions([
          IconButton(
            onPressed: () async {
              if (group?.roomId != null) {
                await getIt<AppRouter>().push(ChatRoute(roomId: group!.roomId));
              }
            },
            icon: const Icon(Icons.message_outlined),
          )
        ])
        .setIsShowBottomDivider(true)
        .setOnTap(() async {
          if (group?.id != null && group?.roomId != null) {
            await getIt<AppRouter>().push(
                GroupInfoRoute(groupId: group!.id, chatRoomId: group!.roomId));
          }
        })
        .build(context);
  }
}

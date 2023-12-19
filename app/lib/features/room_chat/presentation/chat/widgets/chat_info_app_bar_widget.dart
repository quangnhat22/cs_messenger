import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/chat_room_info/chat_room_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInfoAppBarWidget extends StatelessWidget {
  const ChatInfoAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomInfoCubit, ChatRoomInfoState>(
      buildWhen: (prev, current) => prev.chatRoomInfo != current.chatRoomInfo,
      builder: (context, state) {
        return Row(
          children: <Widget>[
            AppAvatarCircleWidget()
                .setSize(AppAvatarSize.medium)
                .setUrl(state.chatRoomInfo?.avatar)
                .build(context),
            SizedBox(
              width: AppSizeExt.of.majorScale(4),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppTextTitleMediumWidget()
                      .setText(state.chatRoomInfo?.name)
                      .build(context),
                  // SizedBox(
                  //   height: AppSizeExt.of.majorScale(1),
                  // ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

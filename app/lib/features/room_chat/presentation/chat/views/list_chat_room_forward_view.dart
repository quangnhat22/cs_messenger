import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_chatroom/list_chat_chatroom_reply_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class ListChatRoomForwardView extends StatelessWidget {
  const ListChatRoomForwardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListChatRoomReplyCubit>(),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSizeExt.of.majorScale(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextTitleLargeWidget()
                .setText(R.strings.forward)
                .setTextStyle(TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ))
                .build(context),
            SizedBox(
              height: AppSizeExt.of.majorScale(3),
            ),
            Expanded(
              child: AppListWidget<ChatRoomModel,
                  AppListViewState<ChatRoomModel>, ListChatRoomReplyCubit>(
                physics: const BouncingScrollPhysics(),
                childWidget: _buildCardChatRoomItem,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardChatRoomItem(
      BuildContext context, ChatRoomModel model, int index) {
    return AppCardChatRoomWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(model.avatar)
            .setSize(AppAvatarSize.mediumLarge)
            .build(context))
        .setTitle(AppTextTitleMediumWidget().setText(model.name).build(context))
        .setIsShowBottomDivider(true)
        .setActions([
          AppButtonOutlineWidget()
              .setAppButtonSize(AppButtonSize.small)
              .setButtonText(R.strings.send)
              .setBorderColor(Theme.of(context).colorScheme.primary)
              .setOnPressed(() {})
              .build(context),
        ])
        .setOnTap(() async {})
        .build(context);
  }
}

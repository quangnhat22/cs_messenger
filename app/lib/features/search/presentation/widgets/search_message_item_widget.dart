import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/list_chat_room/widgets/room_chat_subtitle_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class SearchMessageItemWidget extends StatelessWidget {
  const SearchMessageItemWidget({super.key, this.chatRoom});

  final ChatRoomModel? chatRoom;

  @override
  Widget build(BuildContext context) {
    return AppCardChatRoomWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(chatRoom?.avatar)
            .setSize(AppAvatarSize.mediumLarge)
            .build(context))
        .setTitle(
            AppTextTitleMediumWidget().setText(chatRoom?.name).build(context))
        .setSubtitle(RoomChatSubTitleWidget(
            author: chatRoom?.message?.author,
            content: chatRoom?.message?.content))
        .setHasTopBorderRadius(true)
        .setIsShowBottomDivider(true)
        .setActions([
      AppTextLabelSmallWidget()
          .setText(chatRoom?.message?.createdAt != null
              ? MessageUtils.getVerboseDateTimeRepresentation(
                  chatRoom!.message!.createdAt!)
              : '-')
          .build(context),
      if (chatRoom?.isCalling != true && chatRoom?.isHasNewMessage == true)
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
      if (chatRoom?.isCalling != true && chatRoom?.isHasNewMessage == true)
        AppDotIndicatorWidget(
          height: AppSizeExt.of.majorScale(3),
          width: AppSizeExt.of.majorScale(3),
          isActive: true,
        ),
      if (chatRoom?.isCalling == true)
        AppButtonOutlineWidget()
            .setAppButtonSize(AppButtonSize.small)
            .setButtonText(R.strings.join)
            .setTextStyle(TextStyle(color: AppColorPalette.of.greenColor[5]))
            .setBorderColor(AppColorPalette.of.greenColor[3])
            .setOnPressed(() async {
          if (chatRoom?.id != null) {
            await getIt<AppRouter>()
                .push(VideoCallRoute(chatRoomId: chatRoom!.id));
          }
        }).build(context),
    ]).setOnTap(() async {
      if (chatRoom?.id != null) {
        await getIt<AppRouter>().push(ChatRoute(
          roomId: chatRoom!.id,
          isLatestMessage: chatRoom?.isLatestMessage ?? true,
          offsetMessageToFind: chatRoom?.offset,
          messageToFind: chatRoom?.message,
        ));
      }
    }).build(context);
  }
}

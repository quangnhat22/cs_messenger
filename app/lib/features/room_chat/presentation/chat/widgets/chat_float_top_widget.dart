import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class ChatFloatTopWidget extends StatelessWidget {
  const ChatFloatTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMessageCubit, ListMessageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorPaddingScale(1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppCardWidget()
                  .setElevation(10)
                  .setLeading(AppAvatarCircleWidget()
                      .setSize(AppAvatarSize.medium)
                      //TODO: set url
                      .setUrl('url')
                      .build(context))
                  .setTitle(AppTextBodyMediumWidget()
                      .setText('1 Participant')
                      .setColor(Theme.of(context).colorScheme.onBackground)
                      .build(context))
                  .setBackgroundColor(Colors.transparent)
                  .setActions([
                AppButtonFilledWidget()
                    .setButtonText(R.strings.join)
                    .setOnPressed(() async {
                      await getIt<AppRouter>()
                          .push(VideoCallRoute(chatRoomId: state.roomId));
                    })
                    .setBackgroundColor(
                        Theme.of(context).colorScheme.tertiaryContainer)
                    .build(context)
              ]).build(context),
            ],
          ),
        );
      },
    );
  }
}

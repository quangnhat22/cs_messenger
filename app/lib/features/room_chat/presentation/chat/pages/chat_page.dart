import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/chat_room_info/chat_room_info_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/views/chat_view.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_info_app_bar_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.roomId,
    this.isLite = false,
    this.isLatestMessage = true,
    this.offsetMessageToFind,
    this.messageToFind,
  });

  final String roomId;
  final bool isLite;
  final bool isLatestMessage;
  final String? offsetMessageToFind;
  final IMessageModel? messageToFind;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<ListMessageCubit>()
              ..initPage(
                roomId,
                isLatestMessage: isLatestMessage,
                offsetMessageToFind: offsetMessageToFind,
                messageToFind: messageToFind,
              ),
          ),
          BlocProvider(
            create: (_) =>
                getIt<ChatRoomInfoCubit>()..getChatRoomDetail(roomId),
          ),
        ],
        child: AppMainPageWidget()
            .setAppBar(!isLite
                ? AppBarWidget()
                    .setTextTitleWidget(const ChatInfoAppBarWidget())
                    .setActions([_appBarActions(context)]).build(context)
                : null)
            .setResizeToAvoidBottomInset(true)
            .setBody(_body(context))
            .build(context));
  }

  Widget _appBarActions(BuildContext context) {
    return BlocListener<ChatRoomInfoCubit, ChatRoomInfoState>(
      listenWhen: (prev, current) =>
          prev.chatRoomInfo?.isCalling != current.chatRoomInfo?.isCalling,
      listener: (context, state) {
        context
            .read<ListMessageCubit>()
            .changeIsCallingStatus(state.chatRoomInfo?.isCalling ?? false);
      },
      child: BlocBuilder<ListMessageCubit, ListMessageState>(
        buildWhen: (prev, current) => prev != current,
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (!state.isCalling)
                IconButton(
                  onPressed: () async {
                    await getIt<AppRouter>()
                        .push(VideoCallRoute(chatRoomId: roomId));
                  },
                  icon: const Icon(Icons.video_camera_front_outlined),
                ),
              BlocBuilder<ChatRoomInfoCubit, ChatRoomInfoState>(
                buildWhen: (prev, current) =>
                    prev.chatRoomInfo != current.chatRoomInfo,
                builder: (context, chatRoomInfoState) {
                  return IconButton(
                    onPressed: () async {
                      if (chatRoomInfoState.chatRoomInfo?.id != null) {
                        if (chatRoomInfoState.chatRoomInfo?.type ==
                            ChatRoomType.group) {
                          await getIt<AppRouter>().push(
                              GroupDetailChatRoomRoute(chatRoomId: roomId));
                        }
                        if (chatRoomInfoState.chatRoomInfo?.type ==
                            ChatRoomType.p2p) {
                          await getIt<AppRouter>().push(
                              PersonalDetailChatRoomRoute(chatRoomId: roomId));
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return const ChatView();
  }
}

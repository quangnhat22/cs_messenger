import 'package:app/components/features/message/chat.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/chat_room_info/chat_room_info_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_float_top_widget.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_info_app_bar_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<ListMessageCubit>()..initPage(roomId),
          ),
          BlocProvider(
            create: (_) =>
                getIt<ChatRoomInfoCubit>()..getChatRoomDetail(roomId),
          ),
        ],
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget()
                .setTextTitleWidget(const ChatInfoAppBarWidget())
                .setActions([_appBarActions(context)]).build(context))
            .setResizeToAvoidBottomInset(true)
            .setBody(_body(context))
            .build(context));
  }

  Widget _appBarActions(BuildContext context) {
    return BlocBuilder<ListMessageCubit, ListMessageState>(
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
            IconButton(
              onPressed: () {
                getIt<AppRouter>()
                    .push(GroupDetailChatRoomRoute(chatRoomId: roomId));
              },
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ListMessageCubit, ListMessageState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Chat(
          scrollPhysics: const BouncingScrollPhysics(),
          currentUserId: state.currentUser?.id ?? '-1',
          messages: state.listMessage,
          isFirstPage: state.isFirstPage,
          isLastPage: state.isLastPage,
          topContainerWidget:
              state.isCalling ? const ChatFloatTopWidget() : null,
          onMessageTap: (_, message) async {
            await context.read<ListMessageCubit>().handleMessageTap(message);
          },
          onAttachmentPressed: () {},
          onPreviewDataFetched: (textMessage, previewData) {
            Logs.d(previewData);
            context
                .read<ListMessageCubit>()
                .previewDataFetched(textMessage, previewData);
          },
          onEndReached: () async {
            await context.read<ListMessageCubit>().getMessagesTopPage();
          },
          // onStartReached: () async {
          //   await context.read<ListMessageCubit>().getMessagesBottomPage();
          // },
          //topContainerWidget: const ChatFloatTopWidget(),
          showUserAvatars: true,
          onEndReachedThreshold: 0.4,
          onStartReachedThreshold: 0.8,
          onSendPressed: (textParam) async {
            context.read<ListMessageCubit>().sendTextMessage(textParam);
          },
          onMapSent: (mapParam) {
            context.read<ListMessageCubit>().sendMapMessage(mapParam);
          },
          onAudioSent: (audioParams) async {
            await context
                .read<ListMessageCubit>()
                .sendAudioMessage(audioParams);
          },
          onFileSent: (fileParams) async {
            await context.read<ListMessageCubit>().sendFileMessage(fileParams);
          },
          onImageSent: (imageParams) async {
            await context
                .read<ListMessageCubit>()
                .sendImageMessage(imageParams);
          },
          onVideoSent: (videoParams) async {
            await context
                .read<ListMessageCubit>()
                .sendVideoMessage(videoParams);
          },
          onStickerSent: (stickerParams) {
            context.read<ListMessageCubit>().sendEmojiMessage(stickerParams);
          },
        );
      },
    );
  }
}

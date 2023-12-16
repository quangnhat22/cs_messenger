import 'package:app/components/features/message/chat.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
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
              create: (_) => getIt<ListMessageCubit>()..initPage(roomId)),
        ],
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget()
                .setTextTitleWidget(const ChatInfoAppBarWidget())
                .setActions([
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_camera_front_outlined),
              ),
              IconButton(
                onPressed: () {
                  getIt<AppRouter>().push(GroupDetailChatRoomRoute(
                      chatRoomId: roomId, groupId: '1'));
                },
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ]).build(context))
            .setResizeToAvoidBottomInset(true)
            .setBody(_body(context))
            .build(context));
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
          onAttachmentPressed: () {},
          onMessageTap: (_, message) async {
            await context.read<ListMessageCubit>().handleMessageTap(message);
          },
          onPreviewDataFetched: (textMessage, previewData) {
            Logs.d(previewData);
            context
                .read<ListMessageCubit>()
                .previewDataFetched(textMessage, previewData);
          },
          isFirstPage: state.isFirstPage,
          isLastPage: state.isLastPage,
          onEndReached: () async {
            await context.read<ListMessageCubit>().getMessagesTopPage();
          },
          // onStartReached: () async {
          //   await context.read<ListMessageCubit>().getMessagesBottomPage();
          // },
          //topContainerWidget: const ChatFloatTopWidget(),
          showUserAvatars: true,
          isLeftStatus: true,
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

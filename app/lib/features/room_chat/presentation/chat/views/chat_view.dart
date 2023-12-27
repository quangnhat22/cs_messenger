import 'package:app/components/features/message/chat.dart';
import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/views/list_chat_room_forward_view.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_float_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:utilities/utilities.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final AutoScrollController _scrollController;

  @override
  void initState() {
    _scrollController = AutoScrollController(keepScrollOffset: false);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMessageCubit, ListMessageState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ListSkeleton();
        }
        return Chat(
          scrollController: _scrollController,
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
          onEndReachedThreshold: 0.75,
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
          repliedMessage: state.tempRepliedMessage,
          onReplyMessage: (message) {
            context.read<ListMessageCubit>().addTempRepliedMessage(message);
          },
          onForwardMessage: (message) async {
            await _showListChatRoomForwardDialog(context);
          },
        );
      },
    );
  }

  Future<void> _showListChatRoomForwardDialog(BuildContext context) async {
    final res = await await showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: context,
      builder: (context) {
        return const ListChatRoomForwardView();
      },
    );
  }
}

import 'package:app/components/features/message/chat.dart';
import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/views/chat_forward_message_view.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_float_top_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:utilities/utilities.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ItemScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ItemScrollController();
    super.initState();
  }

  @override
  void dispose() {
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
          itemScrollController: _scrollController,
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
          onStartReached: () async {
            await context.read<ListMessageCubit>().getMessagesBottomPage();
          },
          //topContainerWidget: const ChatFloatTopWidget(),
          showUserAvatars: true,
          onEndReachedThreshold: 0.6,
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
            if (message != null) {
              await _showListChatRoomForwardDialog(context, message);
            }
          },
          onFindIndexMessage: (id) async {
            return await context.read<ListMessageCubit>().findIndexMessage(id);
          },
          onRefreshPage: () async {
            await context.read<ListMessageCubit>().initPage(
                  state.roomId,
                  isLatestMessage: true,
                );
          },
        );
      },
    );
  }

  Future<void> _showListChatRoomForwardDialog(
      BuildContext context, IMessageModel replyMessage) async {
    final chatRoomId = await showModalBottomSheet<String?>(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: context,
      builder: (context) {
        return const ChatForwardMessageView();
      },
    );

    if (chatRoomId != null && context.mounted) {
      await context
          .read<ListMessageCubit>()
          .sendForwardMessage(chatRoomId, replyMessage);
      if (context.mounted) {
        AppSnackBarWidget()
            .setLabelText('Forward message success!')
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .showSnackBarWithContext(context);
      }
    }
  }
}

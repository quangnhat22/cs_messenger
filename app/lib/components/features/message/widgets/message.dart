import 'package:app/components/features/message/conditional/conditional.dart';
import 'package:app/components/features/message/model/bubble_rtl_alignment.dart';
import 'package:app/components/features/message/model/emoji_enlargement_behavior.dart';
import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/message/widgets/text_message.dart';
import 'package:app/components/features/message/widgets/user_avatar.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'file_message.dart';
import 'image_message.dart';
import 'message_status.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.emojiEnlargementBehavior,
    required this.roundBorder,
    required this.showStatus,
    required this.isLeftStatus,
    required this.showUserAvatars,
    required this.messageWidth,
    required this.showName,
    required this.showAvatar,
    required this.hideBackgroundOnEmojiMessages,
    required this.textMessageOptions,
    required this.usePreviewData,
    this.userAgent,
    this.imageHeaders,
    this.bubbleRtlAlignment,
    this.textMessageBuilder,
    this.audioMessageBuilder,
    this.fileMessageBuilder,
    this.imageMessageBuilder,
    this.videoMessageBuilder,
    this.mapMessageBuilder,
    this.onAvatarTap,
    this.onMessageTap,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageVisibilityChanged,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.imageProviderBuilder,
    this.onPreviewDataFetched,
  });

  /// Any message type.
  final IMessageModel message;

  /// Determine the alignment of the bubble for RTL languages. Has no effect
  /// for the LTR languages.
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Controls the enlargement behavior of the emojis in the
  /// [types.TextMessage].
  /// Defaults to [EmojiEnlargementBehavior.multi].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  ///current user id
  final String currentUserId;

  /// Rounds border of the message to visually group messages together.
  final bool roundBorder;

  /// Show message's status.
  final bool showStatus;

  /// This is used to determine if the status icon should be on the left or
  /// right side of the message.
  /// This is only used when [showStatus] is true.
  /// Defaults to false.
  final bool isLeftStatus;

  /// Show user avatars for received messages. Useful for a group chat.
  final bool showUserAvatars;

  /// Maximum message width.
  final int messageWidth;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Show user avatar for the received message. Useful for a group chat.
  final bool showAvatar;

  /// Hide background for messages containing only emojis.
  final bool hideBackgroundOnEmojiMessages;

  final bool usePreviewData;

  final String? userAgent;

  final TextMessageOptions textMessageOptions;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  final void Function(UserModel)? onAvatarTap;

  /// Called when user taps on any message.
  final void Function(BuildContext context, IMessageModel)? onMessageTap;

  /// Called when user double taps on any message.
  final void Function(BuildContext context, IMessageModel)? onMessageDoubleTap;

  /// Called when user makes a long press on any message.
  final void Function(BuildContext context, IMessageModel)? onMessageLongPress;

  /// Called when the message's visibility changes.
  final void Function(IMessageModel, bool visible)? onMessageVisibilityChanged;

  /// Called when user makes a long press on status icon in any message.
  final void Function(BuildContext context, IMessageModel)?
      onMessageStatusLongPress;

  /// Called when user makes a long press on status icon in any message.
  final void Function(BuildContext context, IMessageModel)? onMessageStatusTap;

  /// Build a text message inside predefined bubble.
  final Widget Function(
    TextMessageModel, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;

  /// Build an audio message inside predefined bubble.
  final Widget Function(VideoMessageModel, {required int messageWidth})?
      videoMessageBuilder;

  /// Build an audio message inside predefined bubble.
  final Widget Function(AudioMessageModel, {required int messageWidth})?
      audioMessageBuilder;

  /// Build a file message inside predefined bubble.
  final Widget Function(FileMessageModel, {required int messageWidth})?
      fileMessageBuilder;

  /// Build an image message inside predefined bubble.
  final Widget Function(ImageMessageModel, {required int messageWidth})?
      imageMessageBuilder;

  /// Build an image message inside predefined bubble.
  final Widget Function(MapMessageModel, {required int messageWidth})?
      mapMessageBuilder;

  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;

  final void Function(TextMessageModel, PreviewDataModel)? onPreviewDataFetched;

  Widget _avatarBuilder() => showAvatar
      ? UserAvatar(
          author: message.author,
          bubbleRtlAlignment: bubbleRtlAlignment,
          imageHeaders: imageHeaders,
          onAvatarTap: onAvatarTap,
        )
      : SizedBox(width: AppSizeExt.of.majorScale(10));

  Widget _statusIcon(BuildContext context) {
    if (!showStatus) return const SizedBox.shrink();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppSizeExt.of.majorPaddingScale(1)),
      child: GestureDetector(
        onLongPress: () => onMessageStatusLongPress?.call(context, message),
        onTap: () => onMessageStatusTap?.call(context, message),
        child: MessageStatus(status: message.status),
      ),
    );
  }

  Widget _bubbleBuilder(
    BuildContext context,
    BorderRadius borderRadius,
    bool currentUserIsAuthor,
    bool enlargeEmojis,
  ) =>
      enlargeEmojis && hideBackgroundOnEmojiMessages
          ? _messageBuilder()
          : Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: !currentUserIsAuthor || message.type == MessageType.image
                    ? Theme.of(context).colorScheme.outline.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: _messageBuilder(),
              ),
            );

  Widget _messageBuilder() {
    switch (message.type) {
      case MessageType.audio:
        final audioMessage = message as AudioMessageModel;
        return audioMessageBuilder != null
            ? audioMessageBuilder!(audioMessage, messageWidth: messageWidth)
            : const SizedBox();
      // case MessageType.custom:
      //   final customMessage = message as types.CustomMessage;
      //   return customMessageBuilder != null
      //       ? customMessageBuilder!(customMessage, messageWidth: messageWidth)
      //       : const SizedBox();
      case MessageType.file:
        final fileMessage = message as FileMessageModel;
        return fileMessageBuilder != null
            ? fileMessageBuilder!(fileMessage, messageWidth: messageWidth)
            : FileMessage(
                message: fileMessage,
                currentUserId: currentUserId,
              );
      case MessageType.image:
        final imageMessage = message as ImageMessageModel;
        return imageMessageBuilder != null
            ? imageMessageBuilder!(imageMessage, messageWidth: messageWidth)
            : ImageMessage(
                currentUserId: currentUserId,
                imageHeaders: imageHeaders,
                imageProviderBuilder: imageProviderBuilder,
                message: imageMessage,
                messageWidth: messageWidth,
              );
      case MessageType.text:
        final textMessage = message as TextMessageModel;
        return textMessageBuilder != null
            ? textMessageBuilder!(
                textMessage,
                messageWidth: messageWidth,
                showName: showName,
              )
            : TextMessage(
                currentUserId: currentUserId,
                emojiEnlargementBehavior: emojiEnlargementBehavior,
                hideBackgroundOnEmojiMessages: hideBackgroundOnEmojiMessages,
                message: textMessage,
                onPreviewDataFetched: onPreviewDataFetched,
                options: textMessageOptions,
                showName: showName,
                usePreviewData: usePreviewData,
                userAgent: userAgent,
              );
      case MessageType.video:
        final videoMessage = message as VideoMessageModel;
        return videoMessageBuilder != null
            ? videoMessageBuilder!(videoMessage, messageWidth: messageWidth)
            : const SizedBox();

      case MessageType.map:
        final mapMessage = message as MapMessageModel;
        return mapMessageBuilder != null
            ? mapMessageBuilder!(mapMessage, messageWidth: messageWidth)
            : const SizedBox();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    final currentUserIsAuthor = currentUserId == message.author.id;

    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            message is TextMessageModel &&
            MessageUtils.isConsistsOfEmojis(
              emojiEnlargementBehavior,
              message as TextMessageModel,
            );

    final messageBorderRadius = AppSizeExt.of.majorScale(5);

    final borderRadius = bubbleRtlAlignment == BubbleRtlAlignment.left
        ? BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomStart: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topEnd: Radius.circular(messageBorderRadius),
            topStart: Radius.circular(messageBorderRadius),
          )
        : BorderRadius.only(
            bottomLeft: Radius.circular(
              currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            bottomRight: Radius.circular(
              !currentUserIsAuthor || roundBorder ? messageBorderRadius : 0,
            ),
            topLeft: Radius.circular(messageBorderRadius),
            topRight: Radius.circular(messageBorderRadius),
          );

    return Container(
      alignment: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? currentUserIsAuthor
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart
          : currentUserIsAuthor
              ? Alignment.centerRight
              : Alignment.centerLeft,
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? EdgeInsetsDirectional.only(
              bottom: AppSizeExt.of.majorScale(1),
              end: MessageUtils.isMobile ? query.padding.right : 0,
              start: AppSizeExt.of.majorScale(5) +
                  (MessageUtils.isMobile ? query.padding.left : 0),
            )
          : EdgeInsets.only(
              bottom: AppSizeExt.of.majorScale(1),
              left: AppSizeExt.of.majorScale(5) +
                  (MessageUtils.isMobile ? query.padding.left : 0),
              right: AppSizeExt.of.majorScale(2) +
                  (MessageUtils.isMobile ? query.padding.right : 0),
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        textDirection: bubbleRtlAlignment == BubbleRtlAlignment.left
            ? null
            : TextDirection.ltr,
        children: <Widget>[
          if (!currentUserIsAuthor && showUserAvatars) _avatarBuilder(),
          if (currentUserIsAuthor && isLeftStatus) _statusIcon(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: messageWidth.toDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onDoubleTap: () => onMessageDoubleTap?.call(context, message),
                  onLongPress: () => onMessageLongPress?.call(context, message),
                  onTap: () => onMessageTap?.call(context, message),
                  child: onMessageVisibilityChanged != null
                      ? VisibilityDetector(
                          key: Key(message.id),
                          onVisibilityChanged: (visibilityInfo) =>
                              onMessageVisibilityChanged!(
                            message,
                            visibilityInfo.visibleFraction > 0.1,
                          ),
                          child: _bubbleBuilder(
                            context,
                            borderRadius.resolve(Directionality.of(context)),
                            currentUserIsAuthor,
                            enlargeEmojis,
                          ),
                        )
                      : _bubbleBuilder(
                          context,
                          borderRadius.resolve(Directionality.of(context)),
                          currentUserIsAuthor,
                          enlargeEmojis,
                        ),
                ),
              ],
            ),
          ),
          if (currentUserIsAuthor && !isLeftStatus) _statusIcon(context),
        ],
      ),
    );
  }
}

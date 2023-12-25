import 'dart:math';

import 'package:app/components/features/message/app_chat_widget.dart';
import 'package:app/components/features/message/input/media_buttons_widget.dart';
import 'package:app/components/features/message/unread_header.dart';
import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/message/widgets/message.dart';
import 'package:app/components/features/message/widgets/system_message.dart';
import 'package:app/components/features/message/widgets/text_message.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:resources/resources.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'conditional/conditional.dart';
import 'image_gallery.dart';
import 'input/input_widget.dart';
import 'model/bubble_rtl_alignment.dart';
import 'model/emoji_enlargement_behavior.dart';

final Map<String, int> chatMessageAutoScrollIndexById = {};

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.messages,
    required this.currentUserId,
    this.repliedMessage,
    this.isLastPage,
    this.isFirstPage,
    required this.scrollController,
    this.scrollPhysics,
    this.useTopSafeAreaInset,
    this.userAgent,
    this.imageHeaders,
    this.customBottomWidget,
    this.listBottomWidget,
    this.onEndReached,
    this.onEndReachedThreshold,
    this.onStartReached,
    this.onStartReachedThreshold,
    this.bubbleRtlAlignment = BubbleRtlAlignment.right,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.emojiEnlargementBehavior = EmojiEnlargementBehavior.multi,
    this.isLeftStatus = false,
    this.showUserAvatars = false,
    this.videoMessageBuilder,
    this.audioMessageBuilder,
    this.fileMessageBuilder,
    this.imageMessageBuilder,
    this.mapMessageBuilder,
    this.onMessageTap,
    this.onMessageDoubleTap,
    this.onMessageLongPress,
    this.onMessageVisibilityChanged,
    this.onMessageStatusLongPress,
    this.onMessageStatusTap,
    this.onAttachmentPressed,
    this.textMessageBuilder,
    this.imageProviderBuilder,
    this.onAvatarTap,
    this.onPreviewDataFetched,
    this.disableImageGallery,
    this.isAttachmentUploading,
    this.inputOptions = const InputOptions(),
    this.imageGalleryOptions = const ImageGalleryOptions(
      maxScale: PhotoViewComputedScale.covered,
      minScale: PhotoViewComputedScale.contained,
    ),
    this.dateFormat,
    this.dateHeaderThreshold = 90000,
    this.dateIsUtc = true,
    this.dateLocale,
    this.groupMessagesThreshold = 60000,
    this.scrollToUnreadOptions = const ScrollToUnreadOptions(),
    this.timeFormat,
    required this.onSendPressed,
    this.bottomContainerWidget,
    this.topContainerWidget,
    this.onImageSent,
    this.onVideoSent,
    this.onFileSent,
    this.onAudioSent,
    this.onStickerSent,
    this.onMapSent,
    this.onReplyMessage,
  });

  final String currentUserId;
  final List<IMessageModel> messages;
  final IMessageModel? repliedMessage;
  final bool showUserAvatars;
  final bool? isLastPage;
  final bool? isFirstPage;
  final bool? useTopSafeAreaInset;
  final String? userAgent;
  final Map<String, String>? imageHeaders;
  final Widget? customBottomWidget;
  final Widget? listBottomWidget;
  final AutoScrollController scrollController;
  final ScrollPhysics? scrollPhysics;
  final Future<void> Function()? onEndReached;
  final double? onEndReachedThreshold;
  final Future<void> Function()? onStartReached;
  final double? onStartReachedThreshold;
  final BubbleRtlAlignment? bubbleRtlAlignment;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final EmojiEnlargementBehavior emojiEnlargementBehavior;
  final bool isLeftStatus;
  final bool? disableImageGallery;
  final bool? isAttachmentUploading;
  final InputOptions inputOptions;
  final ImageGalleryOptions imageGalleryOptions;

  final void Function(TextMessageParam) onSendPressed;
  final void Function(BuildContext context, IMessageModel)? onMessageTap;
  final void Function(BuildContext context, IMessageModel)? onMessageDoubleTap;
  final void Function(BuildContext context, IMessageModel)? onMessageLongPress;
  final void Function(IMessageModel, bool visible)? onMessageVisibilityChanged;
  final void Function(BuildContext context, IMessageModel)?
      onMessageStatusLongPress;
  final void Function(BuildContext context, IMessageModel)? onMessageStatusTap;
  final VoidCallback? onAttachmentPressed;
  final Widget Function(
    TextMessageModel, {
    required int messageWidth,
    required bool showName,
  })? textMessageBuilder;
  final Widget Function(VideoMessageModel, {required int messageWidth})?
      videoMessageBuilder;
  final Widget Function(AudioMessageModel, {required int messageWidth})?
      audioMessageBuilder;
  final Widget Function(FileMessageModel, {required int messageWidth})?
      fileMessageBuilder;
  final Widget Function(ImageMessageModel, {required int messageWidth})?
      imageMessageBuilder;
  final Widget Function(MapMessageModel, {required int messageWidth})?
      mapMessageBuilder;
  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;
  final void Function(UserModel)? onAvatarTap;
  final void Function(TextMessageModel, PreviewDataModel)? onPreviewDataFetched;
  final void Function(IMessageModel?)? onReplyMessage;

  final DateFormat? dateFormat;
  final int dateHeaderThreshold;
  final bool dateIsUtc;
  final String? dateLocale;
  final int groupMessagesThreshold;
  final ScrollToUnreadOptions scrollToUnreadOptions;
  final DateFormat? timeFormat;

  ///bottom float container widget
  final Widget? bottomContainerWidget;

  ///top float widget in chat app
  final Widget? topContainerWidget;

  //function handle send message
  final void Function(ImageMessageParam)? onImageSent;
  final void Function(VideoMessageParam)? onVideoSent;
  final void Function(FileMessageParam)? onFileSent;
  final void Function(AudioMessageParam)? onAudioSent;
  final void Function(EmojiMessageParam)? onStickerSent;
  final void Function(MapMessageParam)? onMapSent;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  /// Used to get the correct auto scroll index from [chatMessageAutoScrollIndexById].
  static const String _unreadHeaderId = 'unread_header_id';

  List<Object> _chatMessages = [];
  List<PreviewImage> _gallery = [];
  PageController? _galleryPageController;
  bool _hadScrolledToUnreadOnOpen = false;
  bool _isImageViewVisible = false;
  bool _isShowMediaOptions = false;

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant Chat oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.messages.isNotEmpty) {
      final result = MessageUtils.calculateChatMessages(
        widget.messages,
        widget.currentUserId,
        dateFormat: widget.dateFormat,
        dateHeaderThreshold: widget.dateHeaderThreshold,
        dateIsUtc: widget.dateIsUtc,
        dateLocale: widget.dateLocale,
        groupMessagesThreshold: widget.groupMessagesThreshold,
        lastReadMessageId: widget.scrollToUnreadOptions.lastReadMessageId,
        showUserNames: false,
        timeFormat: widget.timeFormat,
      );

      _chatMessages = result[0] as List<Object>;
      _gallery = result[1] as List<PreviewImage>;

      _refreshAutoScrollMapping();
      _maybeScrollToFirstUnread();
    }
  }

  @override
  void dispose() {
    _galleryPageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).colorScheme.background,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInQuad,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: widget.messages.isEmpty
                      ? Center(
                          child: R.svgs.icEmptyMessage.svg(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: MediaQuery.sizeOf(context).height * 0.4,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              _isShowMediaOptions = false;
                            });
                            // widget.onBackgroundTap?.call();
                          },
                          child: LayoutBuilder(
                            builder: (
                              BuildContext context,
                              BoxConstraints constraints,
                            ) =>
                                AppChatWidget(
                              currentUserId: widget.currentUserId,
                              bottomWidget: widget.listBottomWidget,
                              bubbleRtlAlignment: widget.bubbleRtlAlignment!,
                              isLastPage: widget.isLastPage,
                              isFirstPage: widget.isFirstPage,
                              itemBuilder: (Object item, int? index) =>
                                  _messageBuilder(item, constraints, index),
                              items: _chatMessages,
                              keyboardDismissBehavior:
                                  widget.keyboardDismissBehavior,
                              onEndReached: widget.onEndReached,
                              onEndReachedThreshold:
                                  widget.onEndReachedThreshold,
                              onStartReached: widget.onStartReached,
                              onStartReachedThreshold:
                                  widget.onStartReachedThreshold,
                              scrollController: widget.scrollController,
                              scrollPhysics: widget.scrollPhysics,
                              // typingIndicatorOptions:
                              //     widget.typingIndicatorOptions,
                              useTopSafeAreaInset: widget.useTopSafeAreaInset ??
                                  MessageUtils.isMobile,
                              bottomContainerWidget:
                                  widget.bottomContainerWidget,
                              topContainerWidget: widget.topContainerWidget,
                            ),
                          ),
                        ),
                ),
                widget.customBottomWidget ??
                    InputWidget(
                      replyMessage: widget.repliedMessage,
                      isAttachmentUploading: widget.isAttachmentUploading,
                      onAttachmentPressed: () {
                        setState(() {
                          _isShowMediaOptions = !_isShowMediaOptions;
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                        widget.onAttachmentPressed?.call();
                      },
                      onSendPressed: widget.onSendPressed,
                      onRemoveReplyMessage: () {
                        widget.onReplyMessage?.call(null);
                      },
                      options: InputOptions(
                        onTextFieldTap: () {
                          setState(() {
                            _isShowMediaOptions = false;
                          });
                        },
                      ),
                    ),
                if (_isShowMediaOptions)
                  MediaButtonsWidget(
                    onAudioSent: widget.onAudioSent,
                    onFileSent: widget.onFileSent,
                    onImageSent: widget.onImageSent,
                    onVideoSent: widget.onVideoSent,
                    onStickerSent: widget.onStickerSent,
                    onMapSent: widget.onMapSent,
                  ),
              ],
            ),
          ),
        ),
        if (_isImageViewVisible)
          ImageGallery(
            imageHeaders: widget.imageHeaders,
            imageProviderBuilder: widget.imageProviderBuilder,
            images: _gallery,
            pageController: _galleryPageController!,
            onClosePressed: _onCloseGalleryPressed,
            options: widget.imageGalleryOptions,
          ),
      ],
    );
  }

  /// We need the index for auto scrolling because it will scroll until it reaches an index higher or equal that what it is scrolling towards. Index will be null for removed messages. Can just set to -1 for auto scroll.
  Widget _messageBuilder(
    Object object,
    BoxConstraints constraints,
    int? index,
  ) {
    if (object is DateHeaderModel) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 8,
          top: 8,
        ),
        child: Text(
          object.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            height: 1.333,
          ),
        ),
      );
    } else if (object is MessageSpacer) {
      return SizedBox(
        height: object.height,
      );
    } else if (object is UnreadHeaderData) {
      return AutoScrollTag(
        controller: widget.scrollController,
        index: index ?? -1,
        key: const Key('unread_header'),
        child: UnreadHeader(
          marginTop: object.marginTop,
        ),
      );
    } else {
      final map = object as Map<String, Object>;
      final message = map['message']! as IMessageModel;

      final Widget messageWidget;

      if (message is SystemMessageModel) {
        messageWidget = SystemMessage(
          message: message.content,
          createdAt: message.createdAt,
        );
      } else {
        const minWidth = 440;
        final messageWidth =
            widget.showUserAvatars && message.author.id != widget.currentUserId
                ? min(constraints.maxWidth * 0.72, minWidth).floor()
                : min(constraints.maxWidth * 0.78, minWidth).floor();
        final Widget msgWidget = Message(
          message: message,
          currentUserId: widget.currentUserId,
          emojiEnlargementBehavior: widget.emojiEnlargementBehavior,
          roundBorder: map['nextMessageInGroup'] == true,
          showStatus: map['showStatus'] == true,
          isLeftStatus: widget.isLeftStatus,
          showUserAvatars: widget.showUserAvatars,
          messageWidth: messageWidth,
          showName: map['showName'] == true,
          showAvatar: map['nextMessageInGroup'] == false,
          hideBackgroundOnEmojiMessages: true,
          textMessageOptions: const TextMessageOptions(),
          usePreviewData: true,
          userAgent: widget.userAgent,
          imageHeaders: widget.imageHeaders,
          bubbleRtlAlignment: widget.bubbleRtlAlignment,
          textMessageBuilder: widget.textMessageBuilder,
          audioMessageBuilder: widget.audioMessageBuilder,
          fileMessageBuilder: widget.fileMessageBuilder,
          imageMessageBuilder: widget.imageMessageBuilder,
          videoMessageBuilder: widget.videoMessageBuilder,
          mapMessageBuilder: widget.mapMessageBuilder,
          onAvatarTap: widget.onAvatarTap,
          onMessageTap: (context, tappedMessage) {
            if (tappedMessage is ImageMessageModel &&
                widget.disableImageGallery != true) {
              _onImagePressed(tappedMessage);
            }
            widget.onMessageTap?.call(context, tappedMessage);
          },
          onMessageDoubleTap: widget.onMessageDoubleTap,
          onMessageLongPress: widget.onMessageLongPress,
          imageProviderBuilder: widget.imageProviderBuilder,
          onMessageVisibilityChanged: widget.onMessageVisibilityChanged,
          onMessageStatusLongPress: widget.onMessageStatusLongPress,
          onMessageStatusTap: widget.onMessageStatusTap,
          onPreviewDataFetched: _onPreviewDataFetched,
          onReplyMessage: widget.onReplyMessage,
        );
        // messageWidget = widget.slidableMessageBuilder == null
        //     ? msgWidget
        //     : widget.slidableMessageBuilder!(message, msgWidget);
        messageWidget = msgWidget;
      }
      return AutoScrollTag(
        controller: widget.scrollController,
        index: index ?? -1,
        key: Key('scroll-${message.id}'),
        highlightColor: Theme.of(context).colorScheme.secondaryContainer,
        child: messageWidget,
      );
    }
  }

  void _onCloseGalleryPressed() {
    setState(() {
      _isImageViewVisible = false;
    });
    _galleryPageController?.dispose();
    _galleryPageController = null;
  }

  void _onImagePressed(ImageMessageModel message) {
    final initialPage = _gallery.indexWhere(
      (element) => element.id == message.id && element.uri == message.uri,
    );
    _galleryPageController = PageController(initialPage: initialPage);
    setState(() {
      _isImageViewVisible = true;
    });
  }

  void _onPreviewDataFetched(
    TextMessageModel message,
    PreviewDataModel previewData,
  ) {
    widget.onPreviewDataFetched?.call(message, previewData);
  }

  void _refreshAutoScrollMapping() {
    chatMessageAutoScrollIndexById.clear();
    var i = 0;
    for (final object in _chatMessages) {
      if (object is UnreadHeaderData) {
        chatMessageAutoScrollIndexById[_unreadHeaderId] = i;
      } else if (object is Map<String, Object>) {
        final message = object['message']! as IMessageModel;
        chatMessageAutoScrollIndexById[message.id] = i;
      }
      i++;
    }
  }

  /// Only scroll to first unread if there are messages and it is the first open.
  void _maybeScrollToFirstUnread() {
    if (widget.scrollToUnreadOptions.scrollOnOpen &&
        _chatMessages.isNotEmpty &&
        !_hadScrolledToUnreadOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) {
          await Future.delayed(widget.scrollToUnreadOptions.scrollDelay);
          scrollToUnreadHeader();
        }
      });
      _hadScrolledToUnreadOnOpen = true;
    }
  }

  void scrollToUnreadHeader() {
    final unreadHeaderIndex = chatMessageAutoScrollIndexById[_unreadHeaderId];
    if (unreadHeaderIndex != null) {
      widget.scrollController.scrollToIndex(
        unreadHeaderIndex,
        duration: widget.scrollToUnreadOptions.scrollDuration,
      );
    }
  }

  void scrollToMessage() {}
}

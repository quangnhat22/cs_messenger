import 'package:app/components/features/message/model/emoji_enlargement_behavior.dart';
import 'package:app/components/features/message/model/matchers.dart';
import 'package:app/components/features/message/model/pattern_style.dart';
import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/message/widgets/user_name.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart'
    as flutter_chat_types;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

/// Widget to reuse the markdown capabilities, e.g., for previews.
class TextMessageText extends StatelessWidget {
  const TextMessageText({
    super.key,
    this.bodyLinkTextStyle,
    this.bodyTextStyle,
    this.boldTextStyle,
    this.codeTextStyle,
    this.maxLines,
    this.options = const TextMessageOptions(),
    this.overflow = TextOverflow.clip,
    required this.text,
  });

  /// Style to apply to anything that matches a link.
  final TextStyle? bodyLinkTextStyle;

  /// Regular style to use for any unmatched text. Also used as basis for the fallback options.
  final TextStyle? bodyTextStyle;

  /// Style to apply to anything that matches bold markdown.
  final TextStyle? boldTextStyle;

  /// Style to apply to anything that matches code markdown.
  final TextStyle? codeTextStyle;

  /// See [ParsedText.maxLines].
  final int? maxLines;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  /// See [ParsedText.overflow].
  final TextOverflow overflow;

  /// Text that is shown as markdown.
  final String text;

  @override
  Widget build(BuildContext context) => ParsedText(
        parse: [
          ...options.matchers,
          mailToMatcher(
            style: bodyLinkTextStyle ??
                bodyTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          urlMatcher(
            onLinkPressed: options.onLinkPressed,
            style: bodyLinkTextStyle ??
                bodyTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          boldMatcher(
            style: boldTextStyle ??
                bodyTextStyle?.merge(PatternStyle.bold.textStyle),
          ),
          italicMatcher(
            style: bodyTextStyle?.merge(PatternStyle.italic.textStyle),
          ),
          lineThroughMatcher(
            style: bodyTextStyle?.merge(PatternStyle.lineThrough.textStyle),
          ),
          codeMatcher(
            style: codeTextStyle ??
                bodyTextStyle?.merge(PatternStyle.code.textStyle),
          ),
        ],
        maxLines: maxLines,
        overflow: overflow,
        regexOptions: const RegexOptions(multiLine: true, dotAll: true),
        selectable: options.isTextSelectable,
        style: bodyTextStyle,
        text: text,
        textWidthBasis: TextWidthBasis.longestLine,
      );
}

/// A class that represents text message widget with optional link preview.
class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.currentUserId,
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.message,
    this.onPreviewDataFetched,
    this.options = const TextMessageOptions(),
    required this.showName,
    required this.usePreviewData,
    this.userAgent,
  });

  final String currentUserId;

  /// See [Message.emojiEnlargementBehavior].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// See [Message.hideBackgroundOnEmojiMessages].
  final bool hideBackgroundOnEmojiMessages;

  /// [types.TextMessage].
  final TextMessageModel message;

  /// See [LinkPreview.onPreviewDataFetched].
  final void Function(TextMessageModel, PreviewDataModel)? onPreviewDataFetched;

  /// Customisation options for the [TextMessage].
  final TextMessageOptions options;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Enables link (URL) preview.
  final bool usePreviewData;

  /// User agent to fetch preview data with.
  final String? userAgent;

  Widget _linkPreview(
    String currentUserId,
    double width,
    BuildContext context,
  ) {
    final linkDescriptionTextStyle = currentUserId == message.author.id
        ? TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.428,
          )
        : TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.428,
          );
    final linkTitleTextStyle = currentUserId == message.author.id
        ? TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            height: 1.375,
          )
        : TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            height: 1.375,
          );

    return LinkPreview(
      enableAnimation: true,
      metadataTextStyle: linkDescriptionTextStyle,
      metadataTitleStyle: linkTitleTextStyle,
      onLinkPressed: options.onLinkPressed,
      onPreviewDataFetched: (previewData) {
        final previewDataModel = PreviewDataModel(
          title: previewData.title,
          description: previewData.description,
          image: previewData.image?.url,
          link: previewData.link,
        );
        _onPreviewDataFetched(previewDataModel);
      },
      openOnPreviewImageTap: options.openOnPreviewImageTap,
      openOnPreviewTitleTap: options.openOnPreviewTitleTap,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(5),
        vertical: AppSizeExt.of.majorPaddingScale(4),
      ),
      previewData: flutter_chat_types.PreviewData(
        description: message.previewData?.description,
        image: message.previewData?.image != null
            ? flutter_chat_types.PreviewDataImage(
                height: 100,
                width: 100,
                url: message.previewData!.image!,
              )
            : null,
        link: message.previewData?.link,
        title: message.previewData?.title,
      ),
      text: message.text,
      textWidget: _textWidgetBuilder(currentUserId, context, false),
      userAgent: userAgent,
      width: width,
    );
  }

  void _onPreviewDataFetched(PreviewDataModel previewData) {
    if (message.previewData == null) {
      onPreviewDataFetched?.call(message, previewData);
    }
  }

  Widget _textWidgetBuilder(
    String currentUserId,
    BuildContext context,
    bool enlargeEmojis,
  ) {
    final bodyLinkTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontStyle: FontStyle.italic);
    final bodyTextStyle = Theme.of(context).textTheme.bodyMedium;
    final boldTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    final codeTextStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontWeight: FontWeight.w200);
    const emojiTextStyle = TextStyle(fontSize: 40);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName) UserName(author: message.author),
        if (enlargeEmojis)
          if (options.isTextSelectable)
            SelectableText(message.text, style: emojiTextStyle)
          else
            Text(message.text, style: emojiTextStyle)
        else
          TextMessageText(
            bodyLinkTextStyle: bodyLinkTextStyle,
            bodyTextStyle: bodyTextStyle,
            boldTextStyle: boldTextStyle,
            codeTextStyle: codeTextStyle,
            options: options,
            text: message.text,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never &&
            MessageUtils.isConsistsOfEmojis(emojiEnlargementBehavior, message);
    final width = MediaQuery.of(context).size.width;

    if (usePreviewData && onPreviewDataFetched != null) {
      final urlRegexp = RegExp(regexLink, caseSensitive: false);
      final matches = urlRegexp.allMatches(message.text);

      if (matches.isNotEmpty) {
        return _linkPreview(currentUserId, width, context);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorMarginScale(5),
        vertical: AppSizeExt.of.majorMarginScale(4),
      ),
      child: _textWidgetBuilder(currentUserId, context, enlargeEmojis),
    );
  }
}

class TextMessageOptions {
  const TextMessageOptions({
    this.isTextSelectable = true,
    this.onLinkPressed,
    this.openOnPreviewImageTap = false,
    this.openOnPreviewTitleTap = false,
    this.matchers = const [],
  });

  /// Whether user can tap and hold to select a text content.
  final bool isTextSelectable;

  /// Custom link press handler.
  final void Function(String)? onLinkPressed;

  /// See [LinkPreview.openOnPreviewImageTap].
  final bool openOnPreviewImageTap;

  /// See [LinkPreview.openOnPreviewTitleTap].
  final bool openOnPreviewTitleTap;

  /// Additional matchers to parse the text.
  final List<MatchText> matchers;
}

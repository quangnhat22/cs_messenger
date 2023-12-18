import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/message/widgets/text_message.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A class that represents system message widget.
class SystemMessage extends StatelessWidget {
  const SystemMessage({
    required this.message,
    this.createdAt,
    this.options = const TextMessageOptions(),
    super.key,
  });

  final DateTime? createdAt;

  final String message;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 24,
          top: 24,
          left: 20,
          right: 20,
        ),
        padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(6 / 4)),
        child: Column(
          children: [
            if (createdAt != null)
              AppTextLabelSmallWidget()
                  .setText(
                      MessageUtils.getVerboseDateTimeRepresentation(createdAt!))
                  .setTextStyle(const TextStyle(fontWeight: FontWeight.bold))
                  .build(context),
            SizedBox(
              height: AppSizeExt.of.majorScale(1),
            ),
            TextMessageText(
              bodyLinkTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
              bodyTextStyle: Theme.of(context).textTheme.bodyMedium,
              boldTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              codeTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w200),
              options: options,
              text: message,
            ),
          ],
        ),
      );
}

@immutable
class SystemMessageTheme {
  const SystemMessageTheme({
    required this.margin,
    this.linkTextStyle,
    required this.textStyle,
    this.boldTextStyle,
    this.codeTextStyle,
  });

  /// Margin around the system message.
  final EdgeInsets margin;

  /// Style to apply to anything that matches a link.
  final TextStyle? linkTextStyle;

  /// Regular style to use for any unmatched text. Also used as basis for the fallback options.
  final TextStyle textStyle;

  /// Style to apply to anything that matches bold markdown.
  final TextStyle? boldTextStyle;

  /// Style to apply to anything that matches code markdown.
  final TextStyle? codeTextStyle;
}

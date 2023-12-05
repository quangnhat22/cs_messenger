import 'package:app/components/features/message/widgets/text_message.dart';
import 'package:flutter/material.dart';

/// A class that represents system message widget.
class SystemMessage extends StatelessWidget {
  const SystemMessage({
    required this.message,
    this.options = const TextMessageOptions(),
    super.key,
  });

  final String message;

  /// See [TextMessage.options].
  final TextMessageOptions options;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          bottom: 24,
          top: 8,
          left: 8,
          right: 8,
        ),
        child: TextMessageText(
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

import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Send',
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 28,
            minWidth: 28,
          ),
          icon: R.pngs.iconSend.image(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: onPressed,
          padding: padding,
          splashRadius: 24,
          tooltip: 'Send text message',
        ),
      );
}

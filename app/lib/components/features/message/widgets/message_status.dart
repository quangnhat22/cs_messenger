import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

/// A class that represents a message status.
class MessageStatus extends StatelessWidget {
  /// Creates a message status widget.
  const MessageStatus({
    super.key,
    required this.status,
  });

  /// Status of the message.
  final StatusMessageType? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StatusMessageType.sent:
        return R.pngs.iconDelivered.image(
          width: 20,
          height: 20,
          color: Theme.of(context).colorScheme.primary,
        );
      case StatusMessageType.error:
        return R.pngs.iconError.image(
          width: 20,
          height: 20,
          color: Theme.of(context).colorScheme.error,
        );

      case StatusMessageType.sending:
        return Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary),
            ),
          ),
        );
      default:
        return const SizedBox(width: 8);
    }
  }
}

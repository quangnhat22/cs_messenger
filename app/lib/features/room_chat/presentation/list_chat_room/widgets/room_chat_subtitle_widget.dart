import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class RoomChatSubTitleWidget extends StatelessWidget {
  const RoomChatSubTitleWidget({
    super.key,
    this.author,
    this.content,
  });

  final UserModel? author;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      textWidthBasis: TextWidthBasis.longestLine,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: author?.name != null && author!.name!.isNotEmpty
            ? '${author?.name}: '
            : '',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.outline,
            ),
        children: [
          TextSpan(
            text: '$content',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

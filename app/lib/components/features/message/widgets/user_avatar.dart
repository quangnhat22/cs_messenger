import 'package:app/components/features/message/model/bubble_rtl_alignment.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];

/// Renders user's avatar or initials next to a message.
class UserAvatar extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatar({
    super.key,
    required this.author,
    this.bubbleRtlAlignment,
    this.imageHeaders,
    this.onAvatarTap,
  });

  /// Author to show image and name initials from.
  final UserModel author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Called when user taps on an avatar.
  final void Function(UserModel)? onAvatarTap;

  /// Returns user avatar and name color based on the ID.
  Color getUserAvatarNameColor(UserModel user, List<Color> colors) =>
      colors[user.id.hashCode % colors.length];

  /// Returns user initials (can have only first letter of firstName/lastName or both).
  String getUserInitials(UserModel user) {
    var initials = '';

    if ((user.name ?? '').isNotEmpty) {
      initials += user.name![0].toUpperCase();
    }

    return initials.trim();
  }

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(author, colors);
    final hasImage = author.avatar != null;
    final initials = getUserInitials(author);

    return Container(
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? const EdgeInsetsDirectional.only(end: 8)
          : const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onAvatarTap?.call(author),
        child: CircleAvatar(
          backgroundColor: hasImage
              ? Theme.of(context).colorScheme.secondaryContainer
              : color,
          backgroundImage: hasImage
              ? NetworkImage(author.avatar!, headers: imageHeaders)
              : null,
          radius: AppSizeExt.of.majorScale(4),
          child: !hasImage
              ? AppTextBodySmallWidget().setText(initials).build(context)
              : null,
        ),
      ),
    );
  }
}

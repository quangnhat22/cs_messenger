import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// Renders user's name as a message heading according to the theme.
class UserName extends StatelessWidget {
  const UserName({
    super.key,
    this.author,
  });

  final UserModel? author;

  @override
  Widget build(BuildContext context) {
    return author?.name == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child:
                AppTextBodyMediumWidget().setText(author!.name).build(context),
          );
  }
}

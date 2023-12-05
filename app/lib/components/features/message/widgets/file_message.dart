import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

/// A class that represents file message widget.
class FileMessage extends StatelessWidget {
  /// Creates a file message widget based on a [types.FileMessage].
  const FileMessage({
    super.key,
    required this.message,
    required this.currentUserId,
  });

  final String currentUserId;
  final FileMessageModel message;

  @override
  Widget build(BuildContext context) {
    final color = currentUserId == message.author.id
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;

    return Semantics(
      label: 'File',
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSizeExt.of.majorPaddingScale(4),
          AppSizeExt.of.majorPaddingScale(4),
          AppSizeExt.of.majorScale(5),
          AppSizeExt.of.majorScale(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(21),
              ),
              height: 42,
              width: 42,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (message.isLoading ?? false)
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        color: color,
                        strokeWidth: 2,
                      ),
                    ),
                  // Image.asset(
                  //   'assets/icon-document.png',
                  //   color: color,
                  // ),
                  R.pngs.iconDocument.image(
                    width: 4,
                    height: 4,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (currentUserId != message.author.id)
                      AppTextBodyMediumWidget()
                          .setText(message.author.name)
                          //TODO: textWidthBasis
                          .build(context),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppSizeExt.of.majorPaddingScale(1)),
                      child: AppTextBodyMediumWidget()
                          .setText(
                              MessageUtils.formatBytes(message.size.truncate()))
                          //TODO: textWidthBasis
                          .build(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

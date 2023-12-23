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
      label: R.strings.file,
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
                borderRadius:
                    BorderRadius.circular(AppSizeExt.of.majorScale(21 / 4)),
              ),
              height: AppSizeExt.of.majorScale(12),
              width: AppSizeExt.of.majorScale(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (message.isLoading)
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        color: currentUserId != message.author.id
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.surfaceTint,
                        strokeWidth: 4,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: currentUserId != message.author.id
                          ? Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.6)
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: R.pngs.iconDocument.image(
                      width: AppSizeExt.of.majorScale(15),
                      height: AppSizeExt.of.majorScale(15),
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsetsDirectional.only(
                    start: AppSizeExt.of.majorScale(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextBodyMediumWidget()
                        .setText(message.name)
                        .setTextStyle(
                            const TextStyle(fontWeight: FontWeight.bold))
                        .build(context),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppSizeExt.of.majorPaddingScale(1)),
                      child: AppTextLabelSmallWidget()
                          .setText(
                              MessageUtils.formatBytes(message.size.truncate()))
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

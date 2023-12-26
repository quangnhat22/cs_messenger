import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  const ReplyMessage({
    super.key,
    this.showClose = true,
    required this.messageReply,
    this.width,
    this.onRemoveReplyMessage,
    this.onTapMessage,
  });

  final bool showClose;
  final double? width;
  final ReplyMessageModel messageReply;
  final void Function()? onRemoveReplyMessage;
  final void Function(String chatRoomId)? onTapMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMessage?.call(messageReply.id);
      },
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorScale(3),
            vertical: AppSizeExt.of.majorScale(2)),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppTextTitleSmallWidget()
                    .setText(messageReply.authorName)
                    .setTextOverFlow(TextOverflow.ellipsis)
                    .setMaxLines(1)
                    .build(context),
                AppTextBodyMediumWidget()
                    .setText(messageReply.content)
                    .setTextOverFlow(TextOverflow.ellipsis)
                    .setMaxLines(3)
                    .build(context)
              ],
            ),
            if (showClose)
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    onRemoveReplyMessage?.call();
                  },
                  child: Icon(
                    Icons.close,
                    size: AppSizeExt.of.majorScale(4),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

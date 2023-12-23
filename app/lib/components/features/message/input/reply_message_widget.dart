import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  const ReplyMessage({
    super.key,
    required this.messageReply,
    this.onRemoveReplyMessage,
  });

  final IMessageModel messageReply;
  final void Function()? onRemoveReplyMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
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
                  .setText(messageReply.author.name)
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
    );
  }
}

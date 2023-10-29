import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_calls/widgets/friend_call_list_call_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

//TODO: refactor code
class ListFriendWidget extends StatelessWidget {
  const ListFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorPaddingScale(2),
            vertical: AppSizeExt.of.majorPaddingScale(3),
          ),
          child: AppTextTitleMediumWidget()
              .setText(R.strings.friends)
              .setTextStyle(TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ))
              .build(context),
        ),
        // Expanded(
        //   child: Card(
        //     elevation: 0,
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(
        //         vertical: AppSizeExt.of.majorPaddingScale(1),
        //         horizontal: AppSizeExt.of.majorPaddingScale(1),
        //       ),
        //       child: const FriendCallListCallHistoryWidget(),
        //     ),
        //   ),
        // )
      ],
    );
  }
}

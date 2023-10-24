import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_calls/widgets/friend_call_list_call_history_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FriendListCallHistoryPage extends StatelessWidget {
  const FriendListCallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(1),
        horizontal: AppSizeExt.of.majorPaddingScale(1),
      ),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(1),
            horizontal: AppSizeExt.of.majorPaddingScale(1),
          ),
          child: const FriendCallListCallHistoryWidget(),
        ),
      ),
    );
  }
}

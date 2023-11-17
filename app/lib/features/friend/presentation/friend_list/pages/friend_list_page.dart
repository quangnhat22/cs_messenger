import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_list/widgets/list_friend_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  void _handleAddNewContactButton(BuildContext context) async {
    await context.router.push(const FriendAddNewContactRoute());
  }

  void _handleFriendRequestButton(BuildContext context) async {
    await context.router.push(const FriendRequestRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppCardWidget()
              .setLeading(const CircleAvatar(
                child: Icon(Icons.person_add_outlined),
              ))
              .setContentPadding(
                  EdgeInsets.all(AppSizeExt.of.majorPaddingScale(3)))
              .setTitle(AppTextTitleMediumWidget()
                  .setText(R.strings.addNewContact)
                  .build(context))
              .setActions([const Icon(Icons.chevron_right)])
              .setOnTap(() => _handleAddNewContactButton(context))
              .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(1 / 4),
          ),
          AppCardWidget()
              .setLeading(CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.people_outline,
                  color: Theme.of(context).colorScheme.background,
                ),
              ))
              .setTitle(AppTextTitleMediumWidget()
                  .setText(R.strings.requestFriend)
                  .build(context))
              .setContentPadding(
                  EdgeInsets.all(AppSizeExt.of.majorPaddingScale(3)))
              .setActions([const Icon(Icons.chevron_right)])
              .setOnTap(() => _handleFriendRequestButton(context))
              .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeExt.of.majorPaddingScale(3),
              vertical: AppSizeExt.of.majorPaddingScale(2),
            ),
            child: AppTextTitleMediumWidget()
                .setText("${R.strings.friends} (${4})")
                .setTextStyle(TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ))
                .build(context),
          ),
          const Expanded(
            child: Card(
              elevation: 0,
              child: ListFriendWidget(),
            ),
          )
        ],
      ),
    );
  }
}

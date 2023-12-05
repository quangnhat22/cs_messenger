import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_list/controllers/friend_list_cubit.dart';
import 'package:app/features/friend/presentation/friend_list/widgets/list_friend_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  void _handleFriendRequestButton(BuildContext context) async {
    await context.router.push(const FriendRequestRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppCardWidget()
              .setLeading(CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surfaceTint,
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
              child:
                  BlocBuilder<GetListFriendCubit, AppListViewState<UserModel>>(
                buildWhen: (previous, current) =>
                    previous.data.length != current.data.length,
                builder: (context, state) {
                  return AppTextTitleMediumWidget()
                      .setText("${R.strings.friends} (${state.data.length})")
                      .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ))
                      .build(context);
                },
              )),
          const Expanded(child: ListFriendWidget())
        ],
      ),
    );
  }
}

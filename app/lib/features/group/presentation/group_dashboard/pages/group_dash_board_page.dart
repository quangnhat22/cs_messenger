import 'package:app/components/features/appBar/sliver_search_app_bar_widget.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_dashboard/controllers/cubit_list_group.dart';
import 'package:app/features/group/presentation/group_dashboard/widgets/group_list_label_widget.dart';
import 'package:app/features/group/presentation/group_dashboard/widgets/group_list_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupDashBoardPage extends StatelessWidget {
  const GroupDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListGroupCubit>(),
      child: AppNestedScrollPageWidget()
          .setSliverAppBar(const SliverSearchAppBarWidget())
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
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
                  .setText(R.strings.createNewGroup)
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
              .setContentPadding(
                  EdgeInsets.all(AppSizeExt.of.majorPaddingScale(3)))
              .setTitle(AppTextTitleMediumWidget()
                  .setText(R.strings.requestGroup)
                  .build(context))
              .setActions([const Icon(Icons.chevron_right)])
              .setOnTap(() => _handleFriendRequestButton(context))
              .build(context),
          SizedBox(
            height: AppSizeExt.of.majorScale(1),
          ),
          const GroupListLabelWidget(),
          const Expanded(child: GroupListWidget()),
          // const Expanded(child: ListFriendWidget())
        ],
      ),
    );
  }

  void _handleAddNewContactButton(BuildContext context) async {
    await context.router.push(const FriendAddNewContactRoute());
  }

  void _handleFriendRequestButton(BuildContext context) async {
    await context.router.push(const FriendRequestRoute());
  }
}

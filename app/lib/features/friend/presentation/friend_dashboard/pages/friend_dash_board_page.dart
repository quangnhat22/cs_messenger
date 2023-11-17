import 'package:app/components/features/appBar/sliver_search_app_bar_widget.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/friend/presentation/friend_calls/controllers/list_call_history_cubit.dart';
import 'package:app/features/friend/presentation/friend_list/controllers/friend_list_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class FriendDashBoardPage extends StatelessWidget {
  const FriendDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ListCallHistoryCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<GetListFriendCubit>(),
        )
      ],
      child: AppNestedScrollPageWidget()
          .setSliverAppBar(const SliverSearchAppBarWidget())
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return AppTapBarWidget().setRoutes(const [
      FriendListCallHistoryRoute(),
      FriendListRoute(),
    ]).setNumbers([0, 0]).setLabels([
      R.strings.recentCall,
      R.strings.listFriend,
    ]).build(context);
  }
}

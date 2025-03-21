import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_friend_request_action/friend_request_action_cubit.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_received_request.dart';
import 'package:app/features/friend/presentation/friend_request/controllers/cubit_list_friend_sent_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class FriendRequestPage extends StatelessWidget {
  const FriendRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ListFriendSentRequestCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ListFriendReceivedRequestCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<FriendRequestActionCubit>(),
        ),
      ],
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.friendRequest)
              .setBackgroundColor(Colors.transparent)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ListFriendSentRequestCubit,
        AppListViewState<RequestModel>>(
      buildWhen: (previous, current) => previous.total != current.total,
      builder: (context, sentState) {
        return BlocBuilder<ListFriendReceivedRequestCubit,
            AppListViewState<RequestModel>>(
          buildWhen: (previous, current) => previous.total != current.total,
          builder: (context, receiveState) {
            return AppTapBarWidget().setRoutes(const [
              FriendReceivedRequestRoute(),
              FriendSentRequestRoute(),
            ]).setNumbers([receiveState.total, sentState.total]).setLabels(
                [R.strings.receive, R.strings.sent]).build(context);
          },
        );
      },
    );
  }
}

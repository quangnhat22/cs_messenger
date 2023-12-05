import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/group/presentation/group_request/controllers/cubit_group_request_action/group_request_action_cubit.dart';
import 'package:app/features/group/presentation/group_request/controllers/cubit_list_group_received_request.dart';
import 'package:app/features/group/presentation/group_request/controllers/cubit_list_group_sent_request.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupRequestPage extends StatelessWidget {
  const GroupRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ListGroupSentRequestCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ListGroupReceivedRequestCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<GroupRequestActionCubit>(),
        ),
      ],
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.groupRequest)
              .setBackgroundColor(Colors.transparent)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ListGroupSentRequestCubit,
        AppListViewState<RequestModel>>(
      buildWhen: (previous, current) => previous.total != current.total,
      builder: (context, sentState) {
        return BlocBuilder<ListGroupReceivedRequestCubit,
            AppListViewState<RequestModel>>(
          buildWhen: (previous, current) => previous.total != current.total,
          builder: (context, receiveState) {
            return AppTapBarWidget().setRoutes(const [
              GroupReceivedRequestRoute(),
              GroupSentRequestRoute(),
            ]).setNumbers([receiveState.total, sentState.total]).setLabels(
                [R.strings.receive, R.strings.sent]).build(context);
          },
        );
      },
    );
  }
}

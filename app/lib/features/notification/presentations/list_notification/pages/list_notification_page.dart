import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/notification/presentations/list_notification/controller/list_notification_cubit.dart';
import 'package:app/features/notification/presentations/list_notification/widgets/list_notification_action_app_bar_widget.dart';
import 'package:app/features/notification/presentations/list_notification/widgets/list_notification_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class ListNotificationPage extends StatelessWidget {
  const ListNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListNotificationCubit>(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setLeading(
                IconButton(
                  onPressed: () async {
                    await context.router.navigate(const HomeRoute());
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
              )
              .setTextTitle(R.strings.notification)
              .setActions([const ListNotificationActionAppBarWidget()]).build(
                  context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return const ListNotificationWidget();
  }
}

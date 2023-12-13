import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/features/group/presentation/group_member/controllers/group_list_member_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupMemberPage extends StatelessWidget {
  const GroupMemberPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GroupListMemberCubit>(),
      child: AppMainPageWidget()
          .setAppBar(
              AppBarWidget().setTextTitle(R.strings.members).build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container();
  }
}

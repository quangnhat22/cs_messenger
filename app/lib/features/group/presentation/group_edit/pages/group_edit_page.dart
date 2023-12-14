import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupEditPage extends StatelessWidget {
  const GroupEditPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(
            AppBarWidget().setTextTitle(R.strings.editGroup).build(context))
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Container();
  }
}

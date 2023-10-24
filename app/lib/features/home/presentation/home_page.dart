import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomTabBuilder().setRoutes(
      const [
        RoomChatDashBoardRoute(),
        FriendDashBoardRoute(),
        GroupDashBoardRoute(),
        SettingDashBoardRoute(),
      ],
    ).setLabels([
      R.strings.home,
      R.strings.friends,
      R.strings.groups,
      R.strings.settings
    ]).setIcons(const [
      Icon(Icons.home_outlined),
      Icon(Icons.person_outline),
      Icon(Icons.group_outlined),
      Icon(Icons.settings_outlined),
    ]).build(context);
  }
}

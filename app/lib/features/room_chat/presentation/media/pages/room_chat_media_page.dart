import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:resources/resources.dart';

@RoutePage()
class RoomChatMediaPage extends StatelessWidget {
  const RoomChatMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(AppBarWidget()
            .setTextTitle(R.strings.seePictureVideosFiles)
            .build(context))
        .setBody(_body(context))
        .build(context);
  }

  Widget? _body(BuildContext context) {
    return AppTapBarWidget().setRoutes(const [
      RoomFileRoute(),
      RoomImageRoute(),
      RoomVideoRoute()
    ]).setLabels(['Image', 'Video', 'File']).build(context);
  }
}

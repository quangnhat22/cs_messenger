import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/tab/app_tab_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/room_chat/presentation/media/controllers/list_media/list_media_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class RoomChatMediaPage extends StatelessWidget {
  const RoomChatMediaPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListMediaCubit>()..getListMessageMedia(roomId),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.seePictureVideosFiles)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget? _body(BuildContext context) {
    return AppTapBarWidget().setRoutes(const [
      RoomImageRoute(),
      RoomVideoRoute(),
      RoomFileRoute(),
    ]).setLabels([
      R.strings.image,
      R.strings.video,
      R.strings.file,
    ]).build(context);
  }
}

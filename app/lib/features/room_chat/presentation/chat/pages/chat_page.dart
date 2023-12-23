import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/chat_room_info/chat_room_info_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/controllers/list_message/list_message_cubit.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_info_app_bar_widget.dart';
import 'package:app/features/room_chat/presentation/chat/widgets/chat_view.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<ListMessageCubit>()..initPage(roomId),
          ),
          BlocProvider(
            create: (_) =>
                getIt<ChatRoomInfoCubit>()..getChatRoomDetail(roomId),
          ),
        ],
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget()
                .setTextTitleWidget(const ChatInfoAppBarWidget())
                .setActions([_appBarActions(context)]).build(context))
            .setResizeToAvoidBottomInset(true)
            .setBody(_body(context))
            .build(context));
  }

  Widget _appBarActions(BuildContext context) {
    return BlocBuilder<ListMessageCubit, ListMessageState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!state.isCalling)
              IconButton(
                onPressed: () async {
                  await getIt<AppRouter>()
                      .push(VideoCallRoute(chatRoomId: roomId));
                },
                icon: const Icon(Icons.video_camera_front_outlined),
              ),
            IconButton(
              onPressed: () {
                getIt<AppRouter>()
                    .push(GroupDetailChatRoomRoute(chatRoomId: roomId));
              },
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return const ChatView();
  }
}

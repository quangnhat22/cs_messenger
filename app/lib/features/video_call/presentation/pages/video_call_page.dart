import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:app/features/video_call/presentation/widgets/video_call_page_view_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VideoCallPage extends StatelessWidget {
  const VideoCallPage({
    super.key,
    required this.chatRoomId,
  });

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CallInfoCubit>()..initPage(chatRoomId),
      child: WillPopScope(
        onWillPop: () async => false,
        child: AppMainPageWidget().setBody(_body(context)).build(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return const VideoCallPageViewWidget();
  }
}

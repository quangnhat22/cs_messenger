import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:app/features/video_call/presentation/views/video_call_prejoin_view.dart';
import 'package:app/features/video_call/presentation/views/video_call_room_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCallPageViewWidget extends StatelessWidget {
  const VideoCallPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallInfoCubit, CallInfoState>(
      buildWhen: (prev, current) => prev.callStatus != current.callStatus,
      builder: (context, state) {
        switch (state.callStatus) {
          case ConnectVideoCallStatus.initial:
          case ConnectVideoCallStatus.connecting:
            return const VideoCallPreJoinView();
          case ConnectVideoCallStatus.connected:
            return const VideoCallRoomView();
        }
      },
    );
  }
}

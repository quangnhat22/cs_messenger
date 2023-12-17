import 'package:app/components/features/video_call/views/room_view.dart';
import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCallRoomView extends StatelessWidget {
  const VideoCallRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallInfoCubit, CallInfoState>(
      builder: (context, state) {
        if (state.room == null || state.listener == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RoomView(state.room!, state.listener!);
        }
      },
    );
  }
}

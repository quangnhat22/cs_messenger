import 'package:app/components/features/video_call/views/prejoin_view.dart';
import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livekit_client/livekit_client.dart';

class VideoCallPreJoinView extends StatelessWidget {
  const VideoCallPreJoinView({super.key});

  @override
  Widget build(BuildContext context) {
    return PreJoinView(
      onConnect:
          (LocalAudioTrack? audioTrack, LocalVideoTrack? videoTrack) async {
        await context
            .read<CallInfoCubit>()
            .connectRoom(audioTrack: audioTrack, videoTrack: videoTrack);
      },
    );
  }
}

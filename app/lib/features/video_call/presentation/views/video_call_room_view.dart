import 'package:app/components/features/video_call/views/room_view.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:app/features/video_call/presentation/views/list_member_view.dart';
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
          return RoomView(
            state.room!,
            state.listener!,
            roomId: state.chatRoomId,
            onShowMembers: () => _showMember(context, state.chatRoomId),
          );
        }
      },
    );
  }

  void _showMember(BuildContext context, String roomId) {
    // getIt<AppRouter>().modalSheetBuilder(ChatRoute(roomId: widget.roomId));
    Navigator.of(context).push(ModalBottomSheetRoute(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Material(
          child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: ListMemberView(chatRoomId: roomId),
      )),
      isScrollControlled: false,
    ));
  }
}

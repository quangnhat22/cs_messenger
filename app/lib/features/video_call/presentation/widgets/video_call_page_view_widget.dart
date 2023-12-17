import 'package:app/features/video_call/presentation/controllers/call_info/call_info_cubit.dart';
import 'package:app/features/video_call/presentation/views/video_call_joined_view.dart';
import 'package:app/features/video_call/presentation/views/video_call_prejoin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCallPageViewWidget extends StatefulWidget {
  const VideoCallPageViewWidget({super.key});

  @override
  State<VideoCallPageViewWidget> createState() =>
      _VideoCallPageViewWidgetState();
}

class _VideoCallPageViewWidgetState extends State<VideoCallPageViewWidget> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallInfoCubit, CallInfoState>(
      listenWhen: (prev, current) => prev.callStatus != current.callStatus,
      listener: (context, state) {
        switch (state.callStatus) {
          case ConnectVideoCallStatus.initial:
          case ConnectVideoCallStatus.connecting:
            setState(() {
              _currentPageIndex = 0;
            });
            break;
          case ConnectVideoCallStatus.connected:
            setState(() {
              _currentPageIndex = 1;
            });
            _pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
            break;
        }
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          VideoCallPreJoinView(),
          VideoCallJoinedView(),
        ],
      ),
    );
  }
}

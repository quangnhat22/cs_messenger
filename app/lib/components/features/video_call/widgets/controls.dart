import 'dart:async';

import 'package:app/components/features/video_call/exts/video_call_exts.dart';
import 'package:app/components/features/video_call/widgets/icon_wrapper.dart';
import 'package:app/components/features/video_call/widgets/pop_up_menu_button_widget.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/chat/pages/chat_page.dart';
import 'package:collection/collection.dart';
import 'package:configs/configs.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class ControlsWidget extends StatefulWidget {
  //
  final Room room;
  final LocalParticipant participant;

  const ControlsWidget(
    this.room,
    this.participant, {
    Key? key,
    this.members,
    required this.roomId,
    this.onShowMembers,
  }) : super(key: key);

  final List<UserModel>? members;
  final String roomId;
  final void Function()? onShowMembers;

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  //
  CameraPosition position = CameraPosition.front;

  StreamSubscription? _subscription;

  LocalParticipant get participant => widget.participant;

  @override
  void initState() {
    super.initState();
    participant.addListener(_onChange);
    _subscription = Hardware.instance.onDeviceChange.stream
        .listen((List<MediaDevice> devices) {
      _loadDevices(devices);
    });
    Hardware.instance.enumerateDevices().then(_loadDevices);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    participant.removeListener(_onChange);
    super.dispose();
  }

  void _loadDevices(List<MediaDevice> devices) async {
    setState(() {});
  }

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  void _disableAudio() async {
    await participant.setMicrophoneEnabled(false);
  }

  Future<void> _enableAudio() async {
    await participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await participant.setCameraEnabled(false);
  }

  void _enableVideo() async {
    await participant.setCameraEnabled(true);
  }

  void _toggleCamera() async {
    final track = participant.videoTracks.firstOrNull?.track;
    if (track == null) return;

    try {
      final newPosition = position.switched();
      await track.setCameraPosition(newPosition);
      setState(() {
        position = newPosition;
      });
    } catch (error) {
      Logs.e('could not restart track: $error');
      return;
    }
  }

  bool get isMuted => participant.isMuted;

  void _enableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          Logs.e('cancelled screenshare');
          return;
        }
        Logs.d('DesktopCapturerSource: ${source.id}');
        var track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            sourceId: source.id,
            maxFrameRate: 15.0,
          ),
        );
        await participant.publishVideoTrack(track);
      } catch (e) {
        Logs.e('could not publish video: $e');
      }
      return;
    }
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          bool hasPermissions = await FlutterBackground.hasPermissions;
          if (!isRetry) {
            final appInfo = await DeviceInfo.getDeviceInfo();
            final androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: R.strings.screenSharing,
              notificationText:
                  R.strings.isSharingTheScreen(appInfo["appName"] ?? 'App'),
              notificationImportance: AndroidNotificationImportance.Default,
              notificationIcon: const AndroidResource(
                name: 'ic_launcher',
                defType: 'mipmap',
              ),
            );
            hasPermissions = await FlutterBackground.initialize(
                androidConfig: androidConfig);
          }
          if (hasPermissions &&
              !FlutterBackground.isBackgroundExecutionEnabled) {
            await FlutterBackground.enableBackgroundExecution();
          }
        } catch (e) {
          if (!isRetry) {
            return await Future<void>.delayed(const Duration(seconds: 1),
                () => requestBackgroundPermission(true));
          }
          Logs.e('could not publish video: $e');
        }
      }

      await requestBackgroundPermission();
    }
    if (lkPlatformIs(PlatformType.iOS)) {
      var track = await LocalVideoTrack.createScreenShareTrack(
        const ScreenShareCaptureOptions(
          useiOSBroadcastExtension: true,
          maxFrameRate: 15.0,
        ),
      );
      await participant.publishVideoTrack(track);
      return;
    }
    await participant.setScreenShareEnabled(
      true,
      captureScreenAudio: true,
      screenShareCaptureOptions: const ScreenShareCaptureOptions(
        maxFrameRate: 15.0,
      ),
    );
  }

  void _disableScreenShare() async {
    await participant.setScreenShareEnabled(false);
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      try {
        //   await FlutterBackground.disableBackgroundExecution();
      } catch (error) {
        Logs.e('error disabling screen share: $error');
      }
    }
  }

  void _onTapDisconnect() async {
    final result = await context.showDisconnectDialog();
    if (result == true) await widget.room.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(2 / 4),
        horizontal: AppSizeExt.of.majorPaddingScale(1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconWrapper(
            backgroundColor: Colors.red,
            onPressed: _onTapDisconnect,
            icon: const Icon(
              Icons.call_end_outlined,
              color: Colors.white,
            ),
          ),
          IconWrapper(
            onPressed: () => participant.isMicrophoneEnabled()
                ? _disableAudio()
                : _enableAudio(),
            icon: participant.isMicrophoneEnabled()
                ? const Icon(
                    Icons.mic_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.mic_off_outlined,
                    color: Colors.white,
                  ),
          ),
          IconWrapper(
            onPressed: () => participant.isCameraEnabled()
                ? _disableVideo()
                : _enableVideo(),
            icon: participant.isCameraEnabled()
                ? const Icon(
                    Icons.videocam_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.videocam_off_outlined,
                    color: Colors.white,
                  ),
          ),
          IconWrapper(
            onPressed: _toggleCamera,
            icon: position == CameraPosition.back
                ? const Icon(
                    Icons.video_camera_back_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.video_camera_front_outlined,
                    color: Colors.white,
                  ),
          ),
          IconWrapper(
            onPressed: participant.isScreenShareEnabled()
                ? _disableScreenShare
                : _enableScreenShare,
            icon: participant.isScreenShareEnabled()
                ? const Icon(
                    Icons.monitor_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.monitor,
                    color: Colors.white,
                  ),
          ),
          PopupMenuButton(
            icon: const IconWrapper(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
            offset: const Offset(0, -120),
            position: PopupMenuPosition.over,
            elevation: AppSizeExt.of.majorScale(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeExt.of.majorScale(4))),
            ),
            surfaceTintColor: Theme.of(context).colorScheme.background,
            onSelected: (value) => _selectMenuItem(value, context),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "message",
                child: PopUpMenuItemButtonWidget(
                  label: R.strings.messenger,
                  icon: Icons.message_outlined,
                  backgroundColor: Colors.black45,
                ),
              ),
              PopupMenuItem(
                value: "member",
                child: PopUpMenuItemButtonWidget(
                  label: R.strings.members,
                  icon: Icons.group_outlined,
                  backgroundColor: Colors.black45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectMenuItem(String value, BuildContext context) async {
    switch (value) {
      case "message":
        {
          _showChatMessage(context);
          return;
        }
      case "member":
        {
          _showMembers();
          return;
        }
    }
  }

  void _showChatMessage(BuildContext context) {
    // getIt<AppRouter>().modalSheetBuilder(ChatRoute(roomId: widget.roomId));
    Navigator.of(context).push(
      ModalBottomSheetRoute(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => Material(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: ChatPage(
              roomId: widget.roomId,
              isLite: true,
            ),
          ),
        ),
        isScrollControlled: false,
      ),
    );
  }

  void _showMembers() {
    widget.onShowMembers?.call();
  }
}

class PopOverMenu extends StatelessWidget {
  const PopOverMenu({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizeExt.of.majorScale(4)),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius:
            BorderRadius.all(Radius.circular(AppSizeExt.of.majorScale(4))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(context),
          if (child != null) child!,
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: AppSizeExt.of.majorScale(3),
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}

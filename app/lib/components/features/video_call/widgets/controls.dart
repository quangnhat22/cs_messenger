import 'dart:async';
import 'dart:convert';

import 'package:app/components/features/video_call/exts/video_call_exts.dart';
import 'package:app/components/features/video_call/widgets/icon_wrapper.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:collection/collection.dart';
import 'package:configs/configs.dart';
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
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  //
  CameraPosition position = CameraPosition.front;

  List<MediaDevice>? _audioInputs;
  List<MediaDevice>? _audioOutputs;
  List<MediaDevice>? _videoInputs;

  StreamSubscription? _subscription;

  bool _speakerphoneOn = false;

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
    _speakerphoneOn = Hardware.instance.speakerOn ?? false;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    participant.removeListener(_onChange);
    super.dispose();
  }

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
    setState(() {});
  }

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  void _unpublishAll() async {
    VideoCallDialogExts.showUnPublishDialog(
        () async => await participant.unpublishAllTracks());
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

  void _selectAudioOutput(MediaDevice device) async {
    await widget.room.setAudioOutputDevice(device);
    setState(() {});
  }

  void _selectAudioInput(MediaDevice device) async {
    await widget.room.setAudioInputDevice(device);
    setState(() {});
  }

  void _selectVideoInput(MediaDevice device) async {
    await widget.room.setVideoInputDevice(device);
    setState(() {});
  }

  void _setSpeakerphoneOn() {
    _speakerphoneOn = !_speakerphoneOn;
    Hardware.instance.setSpeakerphoneOn(_speakerphoneOn);
    setState(() {});
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

  void _onTapUpdateSubscribePermission() async {
    final result = await context.showSubscribePermissionDialog();
    if (result != null) {
      try {
        widget.room.localParticipant?.setTrackSubscriptionPermissions(
          allParticipantsAllowed: result,
        );
      } catch (error) {
        await context.showErrorDialog(error);
      }
    }
  }

  void _onTapSimulateScenario() async {
    final result = await context.showSimulateScenarioDialog();
    if (result != null) {
      Logs.d('$result');

      if (SimulateScenarioResult.e2eeKeyRatchet == result) {
        await widget.room.e2eeManager?.ratchetKey();
      }

      if (SimulateScenarioResult.participantMetadata == result) {
        widget.room.localParticipant?.setMetadata(
            'new metadata ${widget.room.localParticipant?.identity}');
      }

      if (SimulateScenarioResult.participantName == result) {
        widget.room.localParticipant
            ?.setName('new name for ${widget.room.localParticipant?.identity}');
      }

      await widget.room.sendSimulateScenario(
        signalReconnect:
            result == SimulateScenarioResult.signalReconnect ? true : null,
        nodeFailure: result == SimulateScenarioResult.nodeFailure ? true : null,
        migration: result == SimulateScenarioResult.migration ? true : null,
        serverLeave: result == SimulateScenarioResult.serverLeave ? true : null,
        switchCandidate:
            result == SimulateScenarioResult.switchCandidate ? true : null,
      );
    }
  }

  void _onTapSendData() async {
    final result = await context.showSendDataDialog();
    if (result == true) {
      await widget.participant.publishData(
        utf8.encode('This is a sample data message'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 15,
    //     horizontal: 15,
    //   ),
    //   child: Wrap(
    //     alignment: WrapAlignment.center,
    //     spacing: 5,
    //     runSpacing: 5,
    //     children: [
    //       IconButton(
    //         onPressed: _unpublishAll,
    //         icon: const Icon(Icons.cancel),
    //         tooltip: 'Unpublish all',
    //       ),
    //       if (participant.isMicrophoneEnabled())
    //         if (lkPlatformIs(PlatformType.android))
    //           IconButton(
    //             onPressed: _disableAudio,
    //             icon: const Icon(Icons.mic),
    //             tooltip: 'mute audio',
    //           )
    //         else
    //           PopupMenuButton<MediaDevice>(
    //             icon: const Icon(Icons.settings_voice),
    //             itemBuilder: (BuildContext context) {
    //               return [
    //                 PopupMenuItem<MediaDevice>(
    //                   value: null,
    //                   onTap: isMuted ? _enableAudio : _disableAudio,
    //                   child: const ListTile(
    //                     leading: Icon(
    //                       Icons.mic_off,
    //                       color: Colors.white,
    //                     ),
    //                     title: Text('Mute Microphone'),
    //                   ),
    //                 ),
    //                 if (_audioInputs != null)
    //                   ..._audioInputs!.map((device) {
    //                     return PopupMenuItem<MediaDevice>(
    //                       value: device,
    //                       child: ListTile(
    //                         leading: (device.deviceId ==
    //                                 widget.room.selectedAudioInputDeviceId)
    //                             ? const Icon(
    //                                 Icons.check_box_outlined,
    //                                 color: Colors.white,
    //                               )
    //                             : const Icon(
    //                                 Icons.check_box_outline_blank,
    //                                 color: Colors.white,
    //                               ),
    //                         title: Text(device.label),
    //                       ),
    //                       onTap: () => _selectAudioInput(device),
    //                     );
    //                   }).toList()
    //               ];
    //             },
    //           )
    //       else
    //         IconButton(
    //           onPressed: _enableAudio,
    //           icon: const Icon(Icons.mic_off),
    //           tooltip: 'un-mute audio',
    //         ),
    //       if (!lkPlatformIs(PlatformType.iOS))
    //         PopupMenuButton<MediaDevice>(
    //           icon: const Icon(Icons.volume_up),
    //           itemBuilder: (BuildContext context) {
    //             return [
    //               const PopupMenuItem<MediaDevice>(
    //                 value: null,
    //                 child: ListTile(
    //                   leading: Icon(
    //                     Icons.speaker,
    //                     color: Colors.white,
    //                   ),
    //                   title: Text('Select Audio Output'),
    //                 ),
    //               ),
    //               if (_audioOutputs != null)
    //                 ..._audioOutputs!.map((device) {
    //                   return PopupMenuItem<MediaDevice>(
    //                     value: device,
    //                     child: ListTile(
    //                       leading: (device.deviceId ==
    //                               widget.room.selectedAudioOutputDeviceId)
    //                           ? const Icon(
    //                               Icons.check_box_outlined,
    //                               color: Colors.white,
    //                             )
    //                           : const Icon(
    //                               Icons.check_box_outline_blank,
    //                               color: Colors.white,
    //                             ),
    //                       title: Text(device.label),
    //                     ),
    //                     onTap: () => _selectAudioOutput(device),
    //                   );
    //                 }).toList()
    //             ];
    //           },
    //         ),
    //       if (!kIsWeb && lkPlatformIs(PlatformType.iOS))
    //         IconButton(
    //           disabledColor: Colors.grey,
    //           onPressed: Hardware.instance.canSwitchSpeakerphone
    //               ? _setSpeakerphoneOn
    //               : null,
    //           icon: Icon(
    //               _speakerphoneOn ? Icons.speaker_phone : Icons.phone_android),
    //           tooltip: 'Switch SpeakerPhone',
    //         ),
    //       if (participant.isCameraEnabled())
    //         PopupMenuButton<MediaDevice>(
    //           icon: const Icon(Icons.videocam_sharp),
    //           itemBuilder: (BuildContext context) {
    //             return [
    //               PopupMenuItem<MediaDevice>(
    //                 value: null,
    //                 onTap: _disableVideo,
    //                 child: const ListTile(
    //                   leading: Icon(
    //                     Icons.videocam_off,
    //                     color: Colors.white,
    //                   ),
    //                   title: Text('Disable Camera'),
    //                 ),
    //               ),
    //               if (_videoInputs != null)
    //                 ..._videoInputs!.map((device) {
    //                   return PopupMenuItem<MediaDevice>(
    //                     value: device,
    //                     child: ListTile(
    //                       leading: (device.deviceId ==
    //                               widget.room.selectedVideoInputDeviceId)
    //                           ? const Icon(
    //                               Icons.check_box_outlined,
    //                               color: Colors.white,
    //                             )
    //                           : const Icon(
    //                               Icons.check_box_outline_blank,
    //                               color: Colors.white,
    //                             ),
    //                       title: Text(device.label),
    //                     ),
    //                     onTap: () => _selectVideoInput(device),
    //                   );
    //                 }).toList()
    //             ];
    //           },
    //         )
    //       else
    //         IconButton(
    //           onPressed: _enableVideo,
    //           icon: const Icon(Icons.videocam_off),
    //           tooltip: 'un-mute video',
    //         ),
    //       IconButton(
    //         icon: Icon(position == CameraPosition.back
    //             ? Icons.video_camera_back
    //             : Icons.video_camera_front),
    //         onPressed: () => _toggleCamera(),
    //         tooltip: 'toggle camera',
    //       ),
    //       if (participant.isScreenShareEnabled())
    //         IconButton(
    //           icon: const Icon(Icons.monitor_outlined),
    //           onPressed: () => _disableScreenShare(),
    //           tooltip: 'unshare screen (experimental)',
    //         )
    //       else
    //         IconButton(
    //           icon: const Icon(Icons.monitor),
    //           onPressed: () => _enableScreenShare(),
    //           tooltip: 'share screen (experimental)',
    //         ),
    //       IconButton(
    //         onPressed: _onTapDisconnect,
    //         icon: const Icon(Icons.close_sharp),
    //         tooltip: 'disconnect',
    //       ),

    //       IconButton(
    //         onPressed: _onTapUpdateSubscribePermission,
    //         icon: const Icon(Icons.settings),
    //         tooltip: 'Subscribe permission',
    //       ),
    //       IconButton(
    //         onPressed: _onTapSimulateScenario,
    //         icon: const Icon(Icons.bug_report),
    //         tooltip: 'Simulate scenario',
    //       ),
    //     ],
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(4),
        horizontal: AppSizeExt.of.majorPaddingScale(2),
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
          IconWrapper(
            onPressed: () => _showMenuButton(context),
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuButton(BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopOverMenu(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.symmetric(
              vertical: AppSizeExt.of.majorPaddingScale(4),
              horizontal: AppSizeExt.of.majorPaddingScale(4),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSizeExt.of.majorScale(4),
              runSpacing: AppSizeExt.of.majorScale(4),
              children: [
                IconWrapper(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                ),
                IconWrapper(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.group_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
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

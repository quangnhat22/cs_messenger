import 'dart:async';
import 'dart:math' as math;

import 'package:app/components/features/video_call/constants/live_kit_constants.dart';
import 'package:app/components/features/video_call/widgets/icon_wrapper.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

class PreJoinView extends StatefulWidget {
  const PreJoinView({
    super.key,
    this.onConnect,
    required this.chatRoomInfo,
  });

  // final JoinArgs args;
  final Future<void> Function(LocalAudioTrack?, LocalVideoTrack?)? onConnect;

  final ChatRoomModel? chatRoomInfo;

  @override
  State<PreJoinView> createState() => _PreJoinViewState();
}

class _PreJoinViewState extends State<PreJoinView> {
  List<MediaDevice> _audioInputs = [];
  List<MediaDevice> _videoInputs = [];
  StreamSubscription? _subscription;

  LocalAudioTrack? _audioTrack;
  LocalVideoTrack? _videoTrack;

  MediaDevice? _selectedVideoDevice;
  MediaDevice? _selectedAudioDevice;

  VideoParameters _selectedVideoParameters = VideoParametersPresets.h720_169;

  bool _busy = false;
  bool _enableVideo = true;
  bool _enableAudio = true;

  @override
  void initState() {
    super.initState();
    _subscription =
        Hardware.instance.onDeviceChange.stream.listen(_loadDevices);
    Hardware.instance.enumerateDevices().then(_loadDevices);
  }

  @override
  void deactivate() {
    _subscription?.cancel();
    super.deactivate();
  }

  @override
  void dispose() async {
    _subscription?.cancel();
    super.dispose();
  }

  void _loadDevices(List<MediaDevice> devices) {
    _audioInputs =
        devices.where((d) => d.kind == LiveKitConstant.audioInput).toList();
    _videoInputs =
        devices.where((d) => d.kind == LiveKitConstant.videoInput).toList();

    if (_audioInputs.isNotEmpty) {
      if (_selectedAudioDevice == null) {
        _selectedAudioDevice = _audioInputs.first;
        Future.delayed(
            const Duration(milliseconds: LiveKitConstant.delayChangeMediaInput),
            () async {
          await _changeLocalAudioTrack();
          setState(() {});
        });
      }
    }
    if (_videoInputs.isNotEmpty) {
      if (_selectedVideoDevice == null) {
        _selectedVideoDevice = _videoInputs.first;
        Future.delayed(
            const Duration(milliseconds: LiveKitConstant.delayChangeMediaInput),
            () async {
          await _changeLocalVideoTrack();
          setState(() {});
        });
      }
    }
  }

  Future<void> _changeLocalAudioTrack() async {
    if (_audioTrack != null) {
      await _audioTrack!.stop();
      _audioTrack = null;
    }

    if (_selectedAudioDevice != null) {
      _audioTrack = await LocalAudioTrack.create(AudioCaptureOptions(
        deviceId: _selectedAudioDevice!.deviceId,
      ));
      await _audioTrack!.start();
    }
  }

  Future<void> _changeLocalVideoTrack() async {
    if (_videoTrack != null) {
      await _videoTrack!.stop();
      _videoTrack = null;
    }

    if (_selectedVideoDevice != null) {
      _videoTrack =
          await LocalVideoTrack.createCameraTrack(CameraCaptureOptions(
        deviceId: _selectedVideoDevice!.deviceId,
        params: _selectedVideoParameters,
        cameraPosition: CameraPosition.back,
      ));
      await _videoTrack!.start();
    }
  }

  Future<void> _setEnableVideo(value) async {
    _enableVideo = value;
    if (!_enableVideo) {
      await _videoTrack?.stop();
      _videoTrack = null;
    } else {
      await _changeLocalVideoTrack();
    }
    setState(() {});
  }

  Future<void> _setEnableAudio(value) async {
    _enableAudio = value;
    if (!_enableAudio) {
      await _audioTrack?.stop();
      _audioTrack = null;
    } else {
      await _changeLocalAudioTrack();
    }
    setState(() {});
  }

  Future<void> _join(BuildContext context) async {
    setState(() {
      _busy = true;
    });

    try {
      if (widget.onConnect != null) {
        await widget.onConnect!(_audioTrack, _videoTrack);
      }
    } catch (error) {
      Logs.e('Could not connect $error');
      // await context.showErrorDialog(error);
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.sizeOf(context).height;

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
          margin: EdgeInsets.only(
              bottom: AppSizeExt.of.majorScale(heightScreen * 0.05)),
          child: SizedBox(
            child: _videoTrack != null
                ? VideoTrackRenderer(
                    _videoTrack!,
                    fit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                  )
                : Container(
                    alignment: Alignment.center,
                    child: LayoutBuilder(
                      builder: (ctx, constraints) => Icon(
                        Icons.videocam_off,
                        color: Colors.blue,
                        size: math.min(
                                constraints.maxHeight, constraints.maxWidth) *
                            0.3,
                      ),
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconWrapper(
                    onPressed: () {
                      _setEnableVideo(!_enableVideo);
                    },
                    backgroundColor: _enableVideo ? null : Colors.white38,
                    icon: _enableVideo
                        ? const Icon(
                            Icons.videocam_outlined,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.videocam_off_outlined,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(
                    width: AppSizeExt.of.majorScale(4),
                  ),
                  IconWrapper(
                    onPressed: () {
                      _setEnableAudio(!_enableAudio);
                    },
                    icon: _enableAudio
                        ? const Icon(
                            Icons.mic_outlined,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.mic_off_outlined,
                            color: Colors.white,
                          ),
                  )
                ],
              ),
              SizedBox(
                height: AppSizeExt.of.majorScale(4),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizeExt.of.majorScale(6)),
                    topRight: Radius.circular(AppSizeExt.of.majorScale(6)),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(4),
                  horizontal: AppSizeExt.of.majorPaddingScale(4),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizeExt.of.majorScale(4),
                      ),
                      AppAvatarCircleWidget()
                          .setUrl(widget.chatRoomInfo?.avatar)
                          .setSize(AppAvatarSize.extraLarge)
                          .build(context),
                      SizedBox(
                        height: AppSizeExt.of.majorScale(4),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizeExt.of.majorPaddingScale(4),
                          horizontal: AppSizeExt.of.majorPaddingScale(4),
                        ),
                        child: AppTextHeadlineSmallWidget()
                            .setText(widget.chatRoomInfo?.name)
                            .setTextAlign(TextAlign.center)
                            .setTextStyle(
                                const TextStyle(fontWeight: FontWeight.bold))
                            .build(context),
                      ),
                      SizedBox(
                        height: AppSizeExt.of.majorScale(4),
                      ),
                      if (!_busy)
                        AppButtonFilledWidget()
                            .setButtonText(R.strings.join)
                            .setTextStyle(TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background))
                            .setOnPressed(_busy ? null : () => _join(context))
                            .build(context),
                      if (!_busy)
                        AppButtonTextWidget()
                            .setButtonText(R.strings.settingAdvanced)
                            .setTextStyle(TextStyle(
                                color: Theme.of(context).colorScheme.primary))
                            .setOnPressed(
                                () async => _showAdvancedSetting(context))
                            .build(context),
                      if (_busy)
                        SizedBox(
                          height: AppSizeExt.of.majorScale(12),
                          width: AppSizeExt.of.majorScale(10),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                              strokeWidth: 4,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: AppSizeExt.of.majorScale(15),
          left: AppSizeExt.of.majorScale(5),
          child: IconWrapper(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () async {
              await _setEnableVideo(false);
              await _setEnableAudio(false);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showAdvancedSetting(BuildContext ctx) async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: ctx,
      builder: ((_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: AppSizeExt.of.majorPaddingScale(6)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: Text(R.strings.disableCamera),
                    hint: Text(R.strings.selectCamera),
                    items: _enableVideo
                        ? _videoInputs
                            .map((MediaDevice item) =>
                                DropdownMenuItem<MediaDevice>(
                                  value: item,
                                  child: Text(
                                    item.label,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList()
                        : [],
                    value: _selectedVideoDevice,
                    onChanged: (MediaDevice? value) async {
                      if (value != null) {
                        _selectedVideoDevice = value;
                        await _changeLocalVideoTrack();
                        setState(() {});
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              if (_enableVideo)
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<VideoParameters>(
                      isExpanded: true,
                      hint: Text(R.strings.selectVideoDimension),
                      items: [
                        VideoParametersPresets.h480_43,
                        VideoParametersPresets.h540_169,
                        VideoParametersPresets.h720_169,
                        VideoParametersPresets.h1080_169,
                      ]
                          .map((VideoParameters item) =>
                              DropdownMenuItem<VideoParameters>(
                                value: item,
                                child: Text(
                                  '${item.dimensions.width}x${item.dimensions.height}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: _selectedVideoParameters,
                      onChanged: (VideoParameters? value) async {
                        if (value != null) {
                          _selectedVideoParameters = value;
                          await _changeLocalVideoTrack();
                          setState(() {});
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: Text(R.strings.selectMicrophone),
                    hint: Text(R.strings.selectMicrophone),
                    items: _enableAudio
                        ? _audioInputs
                            .map((MediaDevice item) =>
                                DropdownMenuItem<MediaDevice>(
                                  value: item,
                                  child: Text(
                                    item.label,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList()
                        : [],
                    value: _selectedAudioDevice,
                    onChanged: (MediaDevice? value) async {
                      if (value != null) {
                        _selectedAudioDevice = value;
                        await _changeLocalAudioTrack();
                        setState(() {});
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ).then((value) async {
      if (value != null) {}
    });
  }
}

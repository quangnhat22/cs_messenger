import 'dart:async';
import 'dart:math' as math;

import 'package:app/components/features/video_call/args/join_args.dart';
import 'package:app/components/features/video_call/constants/live_kit_constants.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';

class PrejoinView extends StatefulWidget {
  const PrejoinView({super.key, required this.args});

  final JoinArgs args;

  @override
  State<PrejoinView> createState() => _PrejoinViewState();
}

class _PrejoinViewState extends State<PrejoinView> {
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
  void dispose() {
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
      ));
      await _videoTrack!.start();
    }
  }

  Future<void> _setEnableVideo(value) async {
    _enableVideo = value;
    if (!_enableVideo) {
      await _videoTrack!.stop();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width),
          padding: EdgeInsets.symmetric(
            vertical: AppSizeExt.of.majorPaddingScale(5),
            horizontal: AppSizeExt.of.majorPaddingScale(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: AppSizeExt.of.majorScale(2)),
                child: SizedBox(
                  width: 320,
                  height: 240,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: _videoTrack != null
                        ? VideoTrackRenderer(
                            _videoTrack!,
                            fit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitContain,
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: LayoutBuilder(
                              builder: (ctx, constraints) => Icon(
                                Icons.videocam_off,
                                color: Colors.blue,
                                size: math.min(constraints.maxHeight,
                                        constraints.maxWidth) *
                                    0.3,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Camera:'),
                    Switch(
                      value: _enableVideo,
                      onChanged: (value) => _setEnableVideo(value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: const Text('Disable Camera'),
                    hint: const Text(
                      'Select Camera',
                    ),
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
                      hint: const Text(
                        'Select Video Dimensions',
                      ),
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
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Microphone:'),
                    Switch(
                      value: _enableAudio,
                      onChanged: (value) => _setEnableAudio(value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: const Text('Disable Microphone'),
                    hint: const Text(
                      'Select Microphone',
                    ),
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
              ElevatedButton(
                onPressed: _busy ? null : () => {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_busy)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    const Text('JOIN'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

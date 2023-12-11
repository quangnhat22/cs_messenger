import 'dart:io';

import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resources/resources.dart';

class VoiceSoundBottomSheet extends StatefulWidget {
  const VoiceSoundBottomSheet({super.key, this.onAudioSent});

  final void Function(AudioMessageParam)? onAudioSent;

  @override
  State<VoiceSoundBottomSheet> createState() => _VoiceSoundBottomSheetState();
}

class _VoiceSoundBottomSheetState extends State<VoiceSoundBottomSheet> {
  final _recorder = FlutterSoundRecorder();
  bool _isRecordeReady = false;
  bool _isSentReady = false;
  String? pathFile;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      AppSnackBarWidget()
          .setLabelText(R.strings.appDontHavePermission)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.error)
          .showSnackBar();
      return;
    }

    await _recorder.openRecorder();
    setState(() {
      _isRecordeReady = true;
    });
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!_isRecordeReady) return;
    setState(() {
      _isSentReady = false;
    });
    await _recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!_isRecordeReady) return;
    final path = await _recorder.stopRecorder();
    setState(() {
      _isRecordeReady = true;
      _isSentReady = true;
      pathFile = path;
    });
  }

  void _handleSendRecord(BuildContext ctx) async {
    if (pathFile != null) {
      File file = File(pathFile!);
      String name = basename(file.path);
      final audioParams = AudioMessageParam(uri: pathFile!, name: name);
      widget.onAudioSent?.call(audioParams);
      await getIt<AppRouter>().pop();
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizeExt.of.majorScale(8),
        left: AppSizeExt.of.majorScale(8),
        right: AppSizeExt.of.majorScale(8),
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppSizeExt.of.majorScale(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<RecordingDisposition>(
              stream: _recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                String twoDigits(int n) => n.toString().padLeft(2, "0");

                final twoDigitsMinutes =
                    twoDigits(duration.inMinutes.remainder(60));

                final twoDigitsSeconds =
                    twoDigits(duration.inSeconds.remainder(60));

                return AppTextTitleLargeWidget()
                    .setText('$twoDigitsMinutes : $twoDigitsSeconds s')
                    .build(context);
              }),
          SizedBox(height: AppSizeExt.of.majorScale(8)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonFilledWidget()
                    .setAppButtonSize(AppButtonSize.large)
                    .setPrefixIcon(Icon(
                      _recorder.isRecording ? Icons.stop : Icons.mic,
                      size: AppSizeExt.of.majorScale(9),
                    ))
                    .setOnPressed(() async {
                      if (_recorder.isRecording) {
                        await stop();
                      } else {
                        await record();
                      }
                      setState(() {});
                    })
                    .setBackgroundColor(
                        Theme.of(context).colorScheme.error.withOpacity(0.8))
                    .build(context),
                if (_isSentReady)
                  SizedBox(
                    width: AppSizeExt.of.majorScale(4),
                  ),
                if (_isSentReady)
                  AppButtonFilledWidget()
                      .setAppButtonSize(AppButtonSize.large)
                      .setPrefixIcon(Icon(
                        Icons.upload,
                        size: AppSizeExt.of.majorScale(9),
                      ))
                      .setOnPressed(() {
                        _handleSendRecord(context);
                      })
                      .setBackgroundColor(Theme.of(context).colorScheme.primary)
                      .build(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

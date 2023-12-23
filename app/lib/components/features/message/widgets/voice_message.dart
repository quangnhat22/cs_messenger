import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class VoiceMessage extends StatelessWidget {
  const VoiceMessage({
    super.key,
    required this.message,
    this.isMe = false,
    required this.screenWidth,
  });

  final AudioMessageModel message;
  final bool isMe;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AudioMessageItem(
      url: message.uri,
      isMe: isMe,
    );
  }
}

class AudioMessageItem extends StatefulWidget {
  const AudioMessageItem({
    super.key,
    required this.url,
    this.isMe = false,
  });

  final String url;
  final bool isMe;

  @override
  State<AudioMessageItem> createState() => _AudioMessageItemState();
}

class _AudioMessageItemState extends State<AudioMessageItem> {
  final audioPlayer = AudioPlayer();
  bool isPlay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future _setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    audioPlayer.setSourceUrl(widget.url);
  }

  @override
  void initState() {
    super.initState();

    _setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlay = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: R.strings.audio,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppSizeExt.of.majorPaddingScale(4),
          AppSizeExt.of.majorPaddingScale(4),
          AppSizeExt.of.majorScale(0),
          AppSizeExt.of.majorScale(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: AppSizeExt.of.majorScale(5),
              backgroundColor: widget.isMe
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () async {
                        if (!isPlay) {
                          // await audioPlayer.play(UrlSource(widget.url));
                          await audioPlayer.resume();
                        } else {
                          await audioPlayer.pause();
                        }
                      },
                      icon: Icon(
                        isPlay ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      iconSize: AppSizeExt.of.majorScale(6),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSizeExt.of.majorScale(4),
            ),
            AppTextBodyMediumWidget()
                .setText(
                    "${MessageUtils.convertDurationToString(position)} / ${MessageUtils.convertDurationToString(duration)}")
                .build(context),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.29,
              child: Slider(
                min: 0.0,
                thumbColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(context).colorScheme.outline,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);
                  //await audioPlayer.resume();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

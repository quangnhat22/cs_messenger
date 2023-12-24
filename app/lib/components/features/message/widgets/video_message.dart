import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/message/widgets/image_message.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({
    super.key,
    required this.currentUserId,
    required this.message,
    this.isMe = false,
    this.messageWidth = 200,
  });

  final VideoMessageModel message;
  final bool isMe;
  final String currentUserId;
  final int messageWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMessage(
          currentUserId: currentUserId,
          message: ImageMessageModel(
            id: message.id,
            author: message.author,
            uri: message.thumbnailUrl ?? '-',
            size: message.size,
            content: message.thumbnailUrl ?? '-',
            type: MessageType.image,
            roomId: message.roomId,
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).height * 0.4,
            status: StatusMessageType.sent,
          ),
          messageWidth: messageWidth,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: 0,
          child: Center(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        VideoPlayPage(url: message.uri),
                  ),
                );
              },
              child: const Icon(Icons.play_arrow),
            ),
          ),
        ),
      ],
    );
  }
}

@RoutePage()
class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key, required this.url});

  final String url;

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;
  bool _isPlay = false;
  bool _isShow = true;

  Future<void> _seekTo(
      {required Duration position, bool isBack = false}) async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final currentPos = await _controller.position;

    if (currentPos == null) return;

    final newPos = (isBack) ? (currentPos - position) : (currentPos + position);

    if (isBack && newPos < _controller.value.duration) {
      _controller.seekTo(const Duration(seconds: 0));
      setState(() {});
    }

    if (!isBack && newPos > _controller.value.duration) {
      _controller.seekTo(_controller.value.duration);
      setState(() {});
    }

    await _controller.seekTo(newPos);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.isPlaying) {
            setState(() {
              _isPlay = true;
            });
          }
          if (!_controller.value.isPlaying) {
            setState(() {
              _isPlay = false;
            });
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(AppBarWidget()
            .setTextTitle(widget.url)
            .setBackgroundColor(Colors.transparent)
            .build(context))
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isShow = !_isShow;
        });
      },
      child: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const CircularProgressIndicator(),
                        SizedBox(height: AppSizeExt.of.majorScale(4)),
                        Text("${R.strings.loading}....")
                      ],
                    ),
                  ),
          ),
          _controller.value.isInitialized
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: _isShow
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizeExt.of.majorPaddingScale(4),
                            horizontal: AppSizeExt.of.majorPaddingScale(4),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppSizeExt.of.majorScale(4)),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizeExt.of.majorPaddingScale(2),
                                  horizontal:
                                      AppSizeExt.of.majorPaddingScale(5),
                                ),
                                child: Column(
                                  children: [
                                    VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      colors: VideoProgressColors(
                                        playedColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    SizedBox(
                                        height: AppSizeExt.of.majorScale(2)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: _controller,
                                          builder: (context,
                                              VideoPlayerValue value, child) {
                                            return Text(MessageUtils
                                                .convertDurationToString(
                                                    value.position));
                                          },
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: _controller,
                                          builder: (context,
                                              VideoPlayerValue value, child) {
                                            return Text(MessageUtils
                                                .convertDurationToString(
                                                    _controller
                                                        .value.duration));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () => _seekTo(
                                        position: Duration(
                                            seconds:
                                                MessageUtils.minSkipDuration),
                                        isBack: true),
                                    icon: const Icon(Icons
                                        .keyboard_double_arrow_left_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                    icon: Icon(
                                      _isPlay ? Icons.pause : Icons.play_arrow,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _seekTo(
                                        position: Duration(
                                            seconds:
                                                MessageUtils.minSkipDuration)),
                                    icon: const Icon(Icons
                                        .keyboard_double_arrow_right_outlined),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

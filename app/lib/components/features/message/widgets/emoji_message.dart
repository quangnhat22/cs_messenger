import 'dart:convert';

import 'package:app/configs/theme/app_theme.dart';
import 'package:configs/configs.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';

class EmojiMessage extends StatelessWidget {
  const EmojiMessage({
    super.key,
    required this.message,
  });

  final EmojiStickerModel message;

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(
      giphy_api_key: BuildConfig.giphyKey,
      // Builder with Stream<GiphyGif> and Instance of GiphyGetWrapper
      builder: (stream, giphyGetWrapper) => StreamBuilder<GiphyGif>(
        stream: stream,
        builder: (context, _) {
          return message.link != null
              ? GiphyGifWidget(
                  imageAlignment: Alignment.center,
                  gif: GiphyGif.fromJson(jsonDecode(message.link!)),
                  giphyGetWrapper: giphyGetWrapper,
                  borderRadius:
                      BorderRadius.circular(AppSizeExt.of.majorScale(4)),
                  showGiphyLabel: false,
                )
              : SizedBox();
        },
      ),
    );
  }
}

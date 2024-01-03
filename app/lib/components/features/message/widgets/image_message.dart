import 'dart:io';

import 'package:app/components/features/skeleton/skeleton.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    super.key,
    required this.currentUserId,
    required this.message,
    this.messageWidth = 160,
  });

  final String currentUserId;

  /// [types.ImageMessage].
  final ImageMessageModel message;

  /// Maximum message width.
  final int messageWidth;

  @override
  Widget build(BuildContext context) {
    return message.status == StatusMessageType.sent
        ? ExtendedImage.network(message.uri,
            width: MediaQuery.sizeOf(context).width * 0.6,
            height: MediaQuery.sizeOf(context).height * 0.3,
            fit: BoxFit.cover,
            shape: BoxShape.rectangle,
            cache: true, loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return Skeleton.rectangular(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  height: MediaQuery.sizeOf(context).height * 0.3,
                );
              case LoadState.completed:
                return state.completedWidget;
              case LoadState.failed:
                return GestureDetector(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      R.svgs.icNoDocument.svg(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                      ),
                      const Positioned(
                        bottom: 0.0,
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Icon(Icons.error_outline),
                      )
                    ],
                  ),
                );
            }
          })
        : Stack(
            children: [
              Image.file(
                File(message.content),
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).height * 0.3,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: AppSizeExt.of.majorScale(20),
                    height: AppSizeExt.of.majorScale(20),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius:
                            BorderRadius.circular(AppSizeExt.of.majorScale(4))),
                    padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
  }
}

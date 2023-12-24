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

// import 'package:app/components/features/message/conditional/conditional.dart';
// import 'package:app/components/features/message/utils/message_utils.dart';
// import 'package:app/components/main/text/app_text_base_builder.dart';
// import 'package:domain/domain.dart';
// import 'package:flutter/material.dart';
//
// class ImageMessage extends StatefulWidget {
//   /// Creates an image message widget based on [types.ImageMessage].
//   const ImageMessage({
//     super.key,
//     this.imageHeaders,
//     this.imageProviderBuilder,
//     required this.currentUserId,
//     required this.message,
//     required this.messageWidth,
//   });
//
//   final String currentUserId;
//
//   /// See [Chat.imageHeaders].
//   final Map<String, String>? imageHeaders;
//
//   /// See [Chat.imageProviderBuilder].
//   final ImageProvider Function({
//     required String uri,
//     required Map<String, String>? imageHeaders,
//     required Conditional conditional,
//   })? imageProviderBuilder;
//
//   /// [types.ImageMessage].
//   final ImageMessageModel message;
//
//   /// Maximum message width.
//   final int messageWidth;
//
//   @override
//   State<ImageMessage> createState() => _ImageMessageState();
// }
//
// /// [ImageMessage] widget state.
// class _ImageMessageState extends State<ImageMessage> {
//   ImageProvider? _image;
//   Size _size = Size.zero;
//   ImageStream? _stream;
//
//   @override
//   void initState() {
//     super.initState();
//     _image = widget.imageProviderBuilder != null
//         ? widget.imageProviderBuilder!(
//             uri: widget.message.uri,
//             imageHeaders: widget.imageHeaders,
//             conditional: Conditional(),
//           )
//         : Conditional().getProvider(
//             widget.message.uri,
//             headers: widget.imageHeaders,
//           );
//
//     //custom image
//     _size = Size(widget.message.width ?? 0, widget.message.height ?? 0);
//   }
//
//   void _getImage() {
//     final oldImageStream = _stream;
//     _stream = _image?.resolve(createLocalImageConfiguration(context));
//     if (_stream?.key == oldImageStream?.key) {
//       return;
//     }
//     final listener = ImageStreamListener(_updateImage);
//     oldImageStream?.removeListener(listener);
//     _stream?.addListener(listener);
//   }
//
//   void _updateImage(ImageInfo info, bool _) {
//     setState(() {
//       _size = Size(
//         info.image.width.toDouble(),
//         info.image.height.toDouble(),
//       );
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (_size.isEmpty) {
//       _getImage();
//     }
//   }
//
//   @override
//   void dispose() {
//     _stream?.removeListener(ImageStreamListener(_updateImage));
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_size.aspectRatio == 0) {
//       return Container(
//         color: Theme.of(context).colorScheme.secondary,
//         height: _size.height,
//         width: _size.width,
//       );
//     } else if (_size.aspectRatio < 0.1 || _size.aspectRatio > 10) {
//       return Container(
//         color: widget.currentUserId == widget.message.author.id
//             ? Theme.of(context).colorScheme.primary
//             : Theme.of(context).colorScheme.secondary,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               height: 64,
//               margin: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
//               width: 64,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image(
//                   fit: BoxFit.cover,
//                   image: _image!,
//                 ),
//               ),
//             ),
//             Flexible(
//               child: Container(
//                 margin: const EdgeInsetsDirectional.fromSTEB(0, 16, 16, 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppTextBodyMediumWidget()
//                         .setText(widget.message.author.name)
//                         //TODO: textWidthBasis
//                         .build(context),
//                     // Text(
//                     //   widget.message.author.name,
//                     //   style: widget.currentUserId == widget.message.author.id
//                     //       ? InheritedChatTheme.of(context)
//                     //           .theme
//                     //           .sentMessageBodyTextStyle
//                     //       : InheritedChatTheme.of(context)
//                     //           .theme
//                     //           .receivedMessageBodyTextStyle,
//                     //   textWidthBasis: TextWidthBasis.longestLine,
//                     // ),
//                     if (widget.message.size != null)
//                       Container(
//                         margin: const EdgeInsets.only(
//                           top: 4,
//                         ),
//                         child: Text(
//                           MessageUtils.formatBytes(
//                               widget.message.size!.truncate()),
//                           style: widget.currentUserId ==
//                                   widget.message.author.id
//                               //TODO: refactor this
//                               ? TextStyle(
//                                   color:
//                                       Theme.of(context).colorScheme.background,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.333,
//                                 )
//                               : TextStyle(
//                                   color: Theme.of(context).colorScheme.primary,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.333,
//                                 ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         constraints: BoxConstraints(
//           maxHeight: _size.height,
//           minWidth: MediaQuery.sizeOf(context).width * 0.25,
//         ),
//         child: AspectRatio(
//           aspectRatio: _size.aspectRatio > 0 ? _size.aspectRatio : 1,
//           child: Image(
//             fit: BoxFit.cover,
//             image: _image!,
//           ),
//         ),
//       );
//     }
//   }
// }

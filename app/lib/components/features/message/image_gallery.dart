import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:utilities/utilities.dart';

import 'conditional/conditional.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({
    super.key,
    this.imageHeaders,
    this.imageProviderBuilder,
    required this.images,
    required this.onClosePressed,
    this.options = const ImageGalleryOptions(),
    required this.pageController,
  });

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// See [Chat.imageProviderBuilder].
  final ImageProvider Function({
    required String uri,
    required Map<String, String>? imageHeaders,
    required Conditional conditional,
  })? imageProviderBuilder;

  /// Images to show in the gallery.
  final List<PreviewImage> images;

  /// Triggered when the gallery is swiped down or closed via the icon.
  final VoidCallback onClosePressed;

  /// Customisation options for the gallery.
  final ImageGalleryOptions options;

  /// Page controller for the image pages.
  final PageController pageController;

  Widget _imageGalleryLoadingBuilder(ImageChunkEvent? event) => Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            value: event == null || event.expectedTotalBytes == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          onClosePressed();
          return true;
        },
        child: Dismissible(
          key: const Key('photo_view_gallery'),
          direction: DismissDirection.down,
          onDismissed: (direction) => onClosePressed(),
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                builder: (BuildContext context, int index) =>
                    PhotoViewGalleryPageOptions(
                  imageProvider: imageProviderBuilder != null
                      ? imageProviderBuilder!(
                          uri: images[index].uri,
                          imageHeaders: imageHeaders,
                          conditional: Conditional(),
                        )
                      : Conditional().getProvider(
                          images[index].uri,
                          headers: imageHeaders,
                        ),
                  minScale: options.minScale,
                  maxScale: options.maxScale,
                ),
                itemCount: images.length,
                loadingBuilder: (context, event) =>
                    _imageGalleryLoadingBuilder(event),
                pageController: pageController,
                scrollPhysics: const ClampingScrollPhysics(),
                onPageChanged: (index) {
                  Logs.d(images[index]);
                },
              ),
              Positioned.directional(
                top: 16,
                end: 4,
                textDirection: Directionality.of(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                      ),
                      CloseButton(
                        color: Colors.red,
                        onPressed: onClosePressed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class ImageGalleryOptions {
  const ImageGalleryOptions({
    this.maxScale,
    this.minScale,
  });

  /// See [PhotoViewGalleryPageOptions.maxScale].
  final dynamic maxScale;

  /// See [PhotoViewGalleryPageOptions.minScale].
  final dynamic minScale;
}

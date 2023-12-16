import 'package:app/components/features/message/image_gallery.dart';
import 'package:app/components/features/message/widgets/image_message.dart';
import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/features/room_chat/presentation/media/controllers/list_media/list_media_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

@RoutePage()
class RoomImageView extends StatefulWidget {
  const RoomImageView({super.key});

  @override
  State<RoomImageView> createState() => _RoomImageViewState();
}

class _RoomImageViewState extends State<RoomImageView> {
  PageController? _galleryPageController;

  bool _isImageViewVisible = false;
  List<PreviewImage> _gallery = [];

  void _onCloseGalleryPressed() {
    setState(() {
      _isImageViewVisible = false;
    });
    _galleryPageController?.dispose();
    _galleryPageController = null;
  }

  void _onImagePressed(ImageMessageModel message) {
    final initialPage = _gallery.indexWhere(
      (element) => element.id == message.id && element.uri == message.uri,
    );
    _galleryPageController = PageController(initialPage: initialPage);
    setState(() {
      _isImageViewVisible = true;
    });
  }

  @override
  void dispose() {
    _galleryPageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthSscreen = MediaQuery.sizeOf(context).width;

    return BlocBuilder<ListMediaCubit, ListMediaState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ListSkeleton();
        }
        if (_isImageViewVisible) {
          return ImageGallery(
            // imageHeaders: widget.imageHeaders,
            // imageProviderBuilder: widget.imageProviderBuilder,
            images: _gallery,
            pageController: _galleryPageController!,
            onClosePressed: _onCloseGalleryPressed,
            options: const ImageGalleryOptions(
              maxScale: PhotoViewComputedScale.covered,
              minScale: PhotoViewComputedScale.contained,
            ),
          );
        }
        return GridView.builder(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemBuilder: (BuildContext s, int index) {
            return GestureDetector(
              onTap: () =>
                  _onImagePressed(state.listPhotos[index] as ImageMessageModel),
              child: ImageMessage(
                currentUserId: '',
                message: state.listPhotos[index] as ImageMessageModel,
                messageWidth: widthSscreen ~/ 3,
              ),
            );
          },
          itemCount: state.listPhotos.length,
        );
      },
    );
  }
}

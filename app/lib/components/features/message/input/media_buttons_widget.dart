import 'dart:convert';

import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
import 'package:app/components/features/message/input/void_record_widget.dart';
import 'package:app/components/features/message/map/picker_map_widget.dart';
import 'package:app/components/features/message/utils/app_assets_picker.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:configs/configs.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resources/resources.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaButtonsWidget extends StatelessWidget {
  const MediaButtonsWidget({
    super.key,
    this.onImageSent,
    this.onVideoSent,
    this.onFileSent,
    this.onAudioSent,
    this.onStickerSent,
    this.onMapSent,
  });

  final void Function(ImageMessageParam)? onImageSent;
  final void Function(VideoMessageParam)? onVideoSent;
  final void Function(FileMessageParam)? onFileSent;
  final void Function(AudioMessageParam)? onAudioSent;
  final void Function(EmojiMessageParam)? onStickerSent;
  final void Function(MapMessageParam)? onMapSent;

  void _pickImage(BuildContext context) async {
    final assetEntity = await showDialog<AssetEntity?>(
      context: context,
      builder: (_) {
        return const AppDialogImagePickerWidget();
      },
    );

    final file = await assetEntity?.file;
    final widthImage = assetEntity?.width;
    final heightImage = assetEntity?.height;
    final name = assetEntity?.title;
    final size = await AppAssetsPicker.getSize(file);

    if (file?.path != null && context.mounted) {
      final imageParam = ImageMessageParam(
        uri: file!.path,
        name: name,
        width: widthImage?.toDouble(),
        height: heightImage?.toDouble(),
        size: size,
      );
      onImageSent?.call(imageParam);
    }
  }

  void _pickVideo(BuildContext ctx) async {
    final assetEntity = await AppAssetsPicker.pickVideo(ctx);
    final file = await assetEntity?.file;
    final name = assetEntity?.title;
    final size = await AppAssetsPicker.getSize(file);
    final duration = assetEntity?.duration;

    if (file?.path != null && ctx.mounted) {
      final documentsDir = (await getApplicationDocumentsDirectory()).path;
      final uint8list = await VideoThumbnail.thumbnailFile(
        video: file!.path,
        imageFormat: ImageFormat.JPEG,
        thumbnailPath: documentsDir,
        maxWidth: 128,
        // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );
      onVideoSent?.call(VideoMessageParam(
        name: name,
        size: size,
        uri: file.path,
        thumbnailUrl: uint8list,
        duration: duration?.toDouble(),
      ));
    }
  }

  void _pickFile(BuildContext ctx) async {
    final file = await AppAssetsPicker.pickFile(ctx);

    if (file != null && file.path != null && ctx.mounted) {
      final filePath = file.path;
      final name = file.name;
      final size = file.size;
      onFileSent?.call(FileMessageParam(
        name: name,
        mimeType: lookupMimeType(filePath!),
        size: size.toDouble(),
        uri: filePath,
        isLoading: true,
      ));
    }
  }

  Future<void> _pickRecord(BuildContext ctx) async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(4)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(4)),
        ),
      ),
      context: ctx,
      builder: ((_) {
        return VoiceSoundBottomSheet(onAudioSent: onAudioSent);
      }),
    ).then((value) async {
      if (value != null) {}
    });
  }

  void _pickStickerAndGif(BuildContext ctx) async {
    final gif =
        await GiphyGet.getGif(context: ctx, apiKey: BuildConfig.giphyKey);
    if (gif != null && ctx.mounted) {
      final content = jsonEncode(gif);
      final stickerParams = EmojiMessageParam(link: content);
      onStickerSent?.call(stickerParams);
    }
  }

  void _pickLocation(BuildContext ctx) async {
    showModalBottomSheet<MapMessageParam>(
      context: ctx,
      builder: (context) {
        return const PickerMapWidget();
      },
    ).then((result) async {
      if (result != null) {
        onMapSent?.call(result);
      }
      await getIt<AppRouter>().pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(6),
        horizontal: AppSizeExt.of.majorPaddingScale(4),
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: AppSizeExt.of.majorScale(1 / 4),
        mainAxisSpacing: AppSizeExt.of.majorScale(1 / 4),
        children: <Widget>[
          COutlineIconButton(
            icon: Icons.image_outlined,
            color: Colors.blue,
            title: R.strings.image,
            onPress: () => _pickImage(context),
          ),
          // COutlineIconButton(
          //   icon: Icons.image_outlined,
          //   color: Colors.cyan,
          //   title: R.strings.gallery,
          //   onPress: () => {},
          // ),
          COutlineIconButton(
            icon: Icons.video_collection_outlined,
            color: Colors.deepPurple,
            title: R.strings.video,
            onPress: () => _pickVideo(context),
          ),
          COutlineIconButton(
            icon: Icons.mic_outlined,
            title: R.strings.voice,
            onPress: () => _pickRecord(context),
          ),
          COutlineIconButton(
            icon: Icons.attach_file_outlined,
            color: Colors.pink,
            title: R.strings.file,
            onPress: () => _pickFile(context),
          ),
          COutlineIconButton(
            icon: Icons.emoji_emotions_outlined,
            color: Colors.orange,
            title: R.strings.stickers,
            onPress: () => _pickStickerAndGif(context),
          ),
          COutlineIconButton(
            icon: Icons.location_on_outlined,
            color: Colors.green,
            title: R.strings.currentLocation,
            onPress: () => _pickLocation(context),
          ),
        ],
      ),
    );
  }
}

class COutlineIconButton extends StatelessWidget {
  const COutlineIconButton({
    Key? key,
    this.icon,
    required this.title,
    this.color = Colors.red,
    this.onPress,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final VoidCallback? onPress;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: onPress,
          child: Column(
            children: [Icon(icon)],
          ),
        ),
        SizedBox(height: AppSizeExt.of.majorScale(2)),
        AppTextBodyMediumWidget().setText(title).build(context),
      ],
    );
  }
}

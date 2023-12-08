import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class MediaButtonsWidget extends StatelessWidget {
  const MediaButtonsWidget({
    super.key,
    this.onImageSent,
  });

  final void Function(String)? onImageSent;

  void _pickImage(BuildContext context) async {
    final filePath = await showDialog(
      context: context,
      builder: (_) {
        return const AppDialogImagePickerWidget();
      },
    );

    if (filePath != null && context.mounted) {
      // await context.read<SettingDashboardCubit>().updateAvatar(filePath);
    }
  }

  // void _pickVideo(BuildContext ctx) async {
  //   final filePath = await AppAssetsPicker.pickVideo(ctx);
  //
  //   if (filePath != null && ctx.mounted) {
  //     await ctx
  //         .read<MessageStreamCubit>()
  //         .sendMessage(type: "video", message: filePath);
  //   }
  // }

  // void _pickRecord(BuildContext ctx) async {
  //   final stateChatRoom = ctx.read<ChatRoomBloc>().state;
  //   if (stateChatRoom is ChatRoomInfoSuccess) {
  //     await showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       context: ctx,
  //       builder: ((context) {
  //         return const VoiceSoundBottomSheet();
  //       }),
  //     ).then((value) async {
  //       if (value != null) {
  //         await ctx
  //             .read<MessageStreamCubit>()
  //             .sendMessage(type: "audio", message: value);
  //       }
  //     });
  //   }
  // }
  //
  // void _pickFile(BuildContext ctx) async {
  //   final stateChatRoom = ctx.read<ChatRoomBloc>().state;
  //   if (stateChatRoom is ChatRoomInfoSuccess) {
  //     String? filePath = await AppAssetsPicker.pickFile(ctx);
  //
  //     if (filePath != null && ctx.mounted) {
  //       await ctx
  //           .read<MessageStreamCubit>()
  //           .sendMessage(type: "file", message: filePath);
  //     }
  //   }
  // }
  //
  // void _pickStickerAndGif(BuildContext ctx) async {
  //   final gif = await GiphyGet.getGif(context: ctx, apiKey: AppConfig.giphyKey);
  //   if (gif != null && ctx.mounted) {
  //     await ctx
  //         .read<MessageStreamCubit>()
  //         .sendMessage(type: "giphy", message: jsonEncode(gif));
  //   }
  // }
  //
  // void _pickLocation(BuildContext ctx) async {
  //   showDialog(
  //     context: ctx,
  //     builder: (context) {
  //       return const MapPage();
  //     },
  //   ).then((result) {
  //     if (result != null && result["currentLocation"] != null) {
  //       final currentLocation = jsonDecode(result["currentLocation"]) as List;
  //       ctx.read<MessageStreamCubit>().sendMessage(
  //           type: "map",
  //           message:
  //               "https://www.google.com/maps/search/?api=1&query=${currentLocation.first},${currentLocation.last}");
  //     }
  //   });
  //   //NavigationUtil.pushNamed(route: RouteName.googleMap);
  // }

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
            icon: Icons.camera_alt_outlined,
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
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.mic_outlined,
            title: R.strings.voice,
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.attach_file_outlined,
            color: Colors.pink,
            title: R.strings.file,
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.emoji_emotions_outlined,
            color: Colors.orange,
            title: R.strings.stickers,
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.location_on_outlined,
            color: Colors.green,
            title: R.strings.currentLocation,
            onPress: () => {},
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

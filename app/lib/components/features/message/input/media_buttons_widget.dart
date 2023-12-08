import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MediaButtonsWidget extends StatelessWidget {
  const MediaButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(6),
        horizontal: AppSizeExt.of.majorPaddingScale(4),
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: AppSizeExt.of.majorScale(1),
        mainAxisSpacing: AppSizeExt.of.majorScale(5),
        children: <Widget>[
          COutlineIconButton(
            icon: Icons.camera_alt_outlined,
            color: Colors.blue,
            title: 'Camera',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.image_outlined,
            color: Colors.cyan,
            title: 'Gallery',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.video_collection_outlined,
            color: Colors.deepPurple,
            title: 'Video',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.mic_outlined,
            title: 'Voice',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.attach_file_outlined,
            color: Colors.pink,
            title: 'Files',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.emoji_emotions_outlined,
            color: Colors.orange,
            title: 'Stickers',
            onPress: () => {},
          ),
          COutlineIconButton(
            icon: Icons.location_on_outlined,
            color: Colors.green,
            title: 'Locations',
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

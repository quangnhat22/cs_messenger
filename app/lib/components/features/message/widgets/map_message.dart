import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class MapMessage extends StatelessWidget {
  const MapMessage({
    super.key,
    required this.message,
    required this.currentUserId,
    this.createdAt,
    required this.screenWidth,
  });

  final MapMessageModel message;
  final String currentUserId;
  final DateTime? createdAt;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: currentUserId != message.author.id
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.6)
                : Theme.of(context).colorScheme.primary.withOpacity(0.6),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Icon(
            Icons.location_on_outlined,
            size: AppSizeExt.of.majorScale(15),
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        SizedBox(width: AppSizeExt.of.majorScale(4)),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: AppSizeExt.of.majorPaddingScale(2)),
                child: AppTextBodyMediumWidget()
                    .setText(R.strings.location)
                    .build(context),
              ),
              SizedBox(height: AppSizeExt.of.majorScale(4)),
              AppButtonTextWidget()
                  .setTextStyle(const TextStyle(fontWeight: FontWeight.bold))
                  .setButtonText(R.strings.openLocation)
                  .setOnPressed(() async {
                await launchUrl(Uri.parse('${message.lat}, ${message.long}'));
              }).build(context)
            ],
          ),
        ),
      ],
    );
  }
}

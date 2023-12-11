import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatInfoAppBarWidget extends StatelessWidget {
  const ChatInfoAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppAvatarCircleWidget()
            .setSize(AppAvatarSize.medium)
            //TODO: set url
            .setUrl(
                'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zNF9mdWxsX2JvZHlfM2RfYXZhdGFyXzNkX3JlbmRlcl9vZl9hX2J1c2luZXNzd19jOWYzODYxYy1lZTYzLTQxOGYtOThmNC02MWJkNGM3OGE1YTZfMS5wbmc.png')
            .build(context),
        SizedBox(
          width: AppSizeExt.of.majorScale(4),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppTextTitleMediumWidget()
                  .setText(
                      'Chat-room hsbdhbshdbhsbdhbshdbshbdhsbdhbshdbshbdhsbdhsbhdbshbdhsbhdbshdbshbdhsbdhbshdbshbdhsb')
                  .build(context),
              // SizedBox(
              //   height: AppSizeExt.of.majorScale(1),
              // ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:app/components/features/button/icon_button_with_text_widget.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupDetailChatRoomPage extends StatelessWidget {
  const GroupDetailChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setAppBar(AppBarWidget().setTextTitle('').build(context))
        .setBackgroundColor(Theme.of(context).colorScheme.surfaceVariant)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
          child: Column(
            children: <Widget>[
              AppAvatarCircleWidget()
                  .setSize(AppAvatarSize.extraLarge)
                  //TODO: set url
                  .setUrl(
                      'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zNF9mdWxsX2JvZHlfM2RfYXZhdGFyXzNkX3JlbmRlcl9vZl9hX2J1c2luZXNzd19jOWYzODYxYy1lZTYzLTQxOGYtOThmNC02MWJkNGM3OGE1YTZfMS5wbmc.png')
                  .build(context),
              SizedBox(height: AppSizeExt.of.majorScale(6)),
              AppTextHeadlineSmallWidget().setText('Group A').build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(6),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    text: 'Thông tin',
                  ),
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.group_outlined,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    text: R.strings.members,
                    onTap: () async {
                      await getIt<AppRouter>()
                          .push(GroupMemberRoute(groupId: '1'));
                    },
                  ),
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.person_add_alt_1_outlined,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    text: 'Mời bạn bè',
                  ),
                ],
              ),
              SizedBox(
                height: AppSizeExt.of.majorScale(2),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizeExt.of.majorPaddingScale(3),
                      vertical: AppSizeExt.of.majorPaddingScale(3),
                    ),
                    child: AppTextTitleMediumWidget()
                        .setText('More action')
                        .setTextStyle(TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ))
                        .build(context),
                  ),
                  Card(
                    elevation: 0,
                    child: Column(
                      children: <Widget>[
                        AppCardBorderWidget()
                            .setLeading(const Icon(Icons.image_outlined))
                            .setTitle(AppTextBodyLargeWidget()
                                .setText(
                                    'Xem file phương tiện, file và liên kết')
                                .build(context))
                            .setHasTopBorderRadius(true)
                            .setIsShowBottomDivider(true)
                            .setActions(
                                [const Icon(Icons.chevron_right)]).setOnTap(
                          () {
                            getIt<AppRouter>()
                                .push(const NotificationSettingRoute());
                          },
                        ).build(context),
                        AppCardBorderWidget()
                            .setLeading(const Icon(Icons.push_pin_outlined))
                            .setTitle(AppTextBodyLargeWidget()
                                .setText('Tin nhắn đã ghim')
                                .build(context))
                            .setIsShowBottomDivider(true)
                            .setActions([
                          Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.error,
                          )
                        ]).setOnTap(
                          () {
                            getIt<AppRouter>().push(const BlockRoute());
                          },
                        ).build(context),
                        AppCardBorderWidget()
                            .setLeading(Icon(
                              Icons.logout_outlined,
                              color: Theme.of(context).colorScheme.error,
                            ))
                            .setTitle(AppTextBodyLargeWidget()
                                .setText('Rời nhóm')
                                .setTextStyle(TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ))
                                .build(context))
                            .build(context)
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

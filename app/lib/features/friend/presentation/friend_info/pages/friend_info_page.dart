import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FriendInfoPage extends StatelessWidget {
  const FriendInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget()
        .setBackgroundColor(Theme.of(context).colorScheme.surface)
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              AppAvatarCircleWidget()
                  .setSize(AppAvatarSize.extraLarge)
                  .setUrl(
                      'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg')
                  .build(context),
              SizedBox(height: AppSizeExt.of.majorScale(4)),
              AppTextTitleLargeWidget().setText('Nguyen Van A').build(context),
              SizedBox(height: AppSizeExt.of.majorScale(4)),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizeExt.of.majorPaddingScale(5),
                    horizontal: AppSizeExt.of.majorPaddingScale(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppTextBodyLargeWidget()
                                .setText('0')
                                .setColor(Theme.of(context).colorScheme.primary)
                                .build(context),
                            SizedBox(height: AppSizeExt.of.majorScale(2)),
                            AppTextBodyLargeWidget()
                                .setText('Bạn chung')
                                .setTextStyle(const TextStyle(
                                    fontWeight: FontWeight.bold))
                                .setColor(Theme.of(context).colorScheme.primary)
                                .build(context),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: VerticalDivider(),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppTextBodyLargeWidget()
                                .setText('0')
                                .setColor(
                                    Theme.of(context).colorScheme.tertiary)
                                .build(context),
                            SizedBox(height: AppSizeExt.of.majorScale(2)),
                            AppTextBodyLargeWidget()
                                .setText('Nhóm chung')
                                .setTextStyle(const TextStyle(
                                    fontWeight: FontWeight.bold))
                                .setColor(
                                    Theme.of(context).colorScheme.tertiary)
                                .build(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizeExt.of.majorScale(4)),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizeExt.of.majorPaddingScale(1)),
                  child: Column(
                    children: <Widget>[
                      AppCardBorderWidget()
                          .setLeading(const Icon(Icons.badge_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Phone')
                              .build(context))
                          .setSubtitle(AppTextBodyMediumWidget()
                              .setText('012345678')
                              .build(context))
                          .setIsShowBottomDivider(true)
                          .build(context),
                      AppCardBorderWidget()
                          .setLeading(const Icon(Icons.male_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Gender')
                              .build(context))
                          .setSubtitle(AppTextBodyMediumWidget()
                              .setText('Male')
                              .build(context))
                          .setIsShowBottomDivider(true)
                          .build(context),
                      AppCardBorderWidget()
                          .setLeading(const Icon(Icons.cake_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Birthday')
                              .build(context))
                          .setSubtitle(AppTextBodyMediumWidget()
                              .setText('22/05/2023')
                              .build(context))
                          .build(context),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizeExt.of.majorScale(4)),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizeExt.of.majorPaddingScale(1)),
                  child: Column(
                    children: <Widget>[
                      AppCardBorderWidget()
                          .setLeading(Icon(
                            Icons.person_add_alt_1_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Add friend')
                              .setColor(Theme.of(context).colorScheme.primary)
                              .build(context))
                          .setOnTap(() {})
                          .setIsShowBottomDivider(true)
                          .build(context),
                      AppCardBorderWidget()
                          .setLeading(Icon(
                            Icons.block_outlined,
                            color: Theme.of(context).colorScheme.error,
                          ))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Block')
                              .setColor(Theme.of(context).colorScheme.error)
                              .build(context))
                          .setOnTap(() {})
                          .build(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

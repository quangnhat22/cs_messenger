import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/setting/presentation/dashboard/widgets/setting_short_user_info_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingDashBoardPage extends StatelessWidget {
  const SettingDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainPageWidget().setBody(_body(context)).build(context);
  }

  Widget _body(BuildContext ctx) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SettingShortUserInfo(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(2),
                  vertical: AppSizeExt.of.majorPaddingScale(3),
                ),
                child: AppTextTitleMediumWidget()
                    .setText('Account')
                    .setTextStyle(TextStyle(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(ctx),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizeExt.of.majorPaddingScale(1)),
                  child: Column(
                    children: <Widget>[
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Update avatar')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Edit profile')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .setOnTap(() {
                        ctx.router.push(const EditProfileRoute());
                      }).build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Change Password')
                              .build(ctx))
                          .build(ctx)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(2),
                  vertical: AppSizeExt.of.majorPaddingScale(3),
                ),
                child: AppTextTitleMediumWidget()
                    .setText('App')
                    .setTextStyle(TextStyle(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(ctx),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizeExt.of.majorPaddingScale(1)),
                  child: Column(
                    children: <Widget>[
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Notification')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Language & Theme')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Devices')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('About')
                              .build(ctx))
                          .setIsShowBottomDivider(true)
                          .build(ctx),
                      AppCardBorderWidget()
                          .setLeading(
                              const Icon(Icons.photo_camera_front_outlined))
                          .setTitle(AppTextBodyLargeWidget()
                              .setText('Delete Account')
                              .build(ctx))
                          .build(ctx)
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

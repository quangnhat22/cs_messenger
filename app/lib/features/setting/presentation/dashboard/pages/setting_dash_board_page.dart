import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/setting/presentation/dashboard/controllers/cubit_setting_dashboard/setting_dashboard_cubit.dart';
import 'package:app/features/setting/presentation/dashboard/widgets/setting_short_user_info_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class SettingDashBoardPage extends StatelessWidget {
  const SettingDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingDashboardCubit>(),
      child: AppMainPageWidget().setBody(_body(context)).build(context),
    );
  }

  void _showDialogChangeAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AppDialogImagePickerWidget();
      },
    ).then((filePath) => {
          if (filePath != null) {debugPrint(filePath)}
        });
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
                    .setText(R.strings.account)
                    .setTextStyle(TextStyle(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(ctx),
              ),
              Card(
                surfaceTintColor: Theme.of(ctx).colorScheme.background,
                child: Column(
                  children: <Widget>[
                    AppCardBorderWidget()
                        .setLeading(
                            const Icon(Icons.photo_camera_front_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.updateAvatar)
                            .build(ctx))
                        .setHasTopBorderRadius(true)
                        .setIsShowBottomDivider(true)
                        .setOnTap(() => _showDialogChangeAvatar(ctx))
                        .build(ctx),
                    AppCardBorderWidget()
                        .setLeading(const Icon(Icons.person_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.editProfile)
                            .build(ctx))
                        .setIsShowBottomDivider(true)
                        .setOnTap(() {
                      getIt<AppRouter>().push(const EditProfileRoute());
                    }).setActions([const Icon(Icons.chevron_right)]).build(ctx),
                    AppCardBorderWidget()
                        .setLeading(const Icon(Icons.security_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.changePassword)
                            .build(ctx))
                        .setActions([const Icon(Icons.chevron_right)]).setOnTap(
                            () {
                      getIt<AppRouter>().push(const ChangePasswordRoute());
                    }).build(ctx)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(2),
                  vertical: AppSizeExt.of.majorPaddingScale(3),
                ),
                child: AppTextTitleMediumWidget()
                    .setText(R.strings.app)
                    .setTextStyle(TextStyle(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(ctx),
              ),
              Card(
                surfaceTintColor: Theme.of(ctx).colorScheme.background,
                child: Column(
                  children: <Widget>[
                    AppCardBorderWidget()
                        .setLeading(const Icon(Icons.notifications_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.notification)
                            .build(ctx))
                        .setHasTopBorderRadius(true)
                        .setIsShowBottomDivider(true)
                        .setActions([const Icon(Icons.chevron_right)]).setOnTap(
                      () {
                        getIt<AppRouter>()
                            .push(const NotificationSettingRoute());
                      },
                    ).build(ctx),
                    AppCardBorderWidget()
                        .setLeading(const Icon(Icons.public_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.themeAndLanguage)
                            .build(ctx))
                        .setIsShowBottomDivider(true)
                        .setActions([const Icon(Icons.chevron_right)]).setOnTap(
                      () {
                        getIt<AppRouter>().push(const ThemeAndLanguageRoute());
                      },
                    ).build(ctx),
                    AppCardBorderWidget()
                        .setLeading(const Icon(Icons.phone_android_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.devices)
                            .build(ctx))
                        .setIsShowBottomDivider(true)
                        .setActions([const Icon(Icons.chevron_right)]).setOnTap(
                      () {
                        getIt<AppRouter>().push(const ListDevicesRoute());
                      },
                    ).build(ctx),
                    AppCardBorderWidget()
                        .setLeading(
                            const Icon(Icons.photo_camera_front_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.about)
                            .build(ctx))
                        .setIsShowBottomDivider(true)
                        .build(ctx),
                    AppCardBorderWidget()
                        .setLeading(
                            const Icon(Icons.photo_camera_front_outlined))
                        .setTitle(AppTextBodyLargeWidget()
                            .setText(R.strings.deleteAccount)
                            .build(ctx))
                        .build(ctx)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

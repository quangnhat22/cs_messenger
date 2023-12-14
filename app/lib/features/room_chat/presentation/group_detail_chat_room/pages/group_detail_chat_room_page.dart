import 'package:app/components/features/button/icon_button_with_text_widget.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/group_detail_chat_room/controllers/group_edit_name_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupDetailChatRoomPage extends StatelessWidget {
  const GroupDetailChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GroupEditNameFormBloc>(),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget().setTextTitle('').build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
          child: Column(
            children: <Widget>[
              AppAvatarCircleWidget()
                  .setSize(AppAvatarSize.extraExtraLarge)
                  //TODO: set url
                  .setUrl(
                      'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zNF9mdWxsX2JvZHlfM2RfYXZhdGFyXzNkX3JlbmRlcl9vZl9hX2J1c2luZXNzd19jOWYzODYxYy1lZTYzLTQxOGYtOThmNC02MWJkNGM3OGE1YTZfMS5wbmc.png')
                  .build(context),
              SizedBox(height: AppSizeExt.of.majorScale(5)),
              AppTextHeadlineLargeWidget().setText('Group A').build(context),
              SizedBox(
                height: AppSizeExt.of.majorScale(5),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    text: 'Thông tin',
                  ),
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    text: R.strings.edit,
                    onTap: () => _buildDialogChangeGroupName(context, '123'),
                  ),
                  IconButtonWithTextWidget(
                    icon: Icon(
                      Icons.group_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    text: R.strings.members,
                    onTap: () async {
                      await getIt<AppRouter>()
                          .push(GroupMemberRoute(groupId: '1'));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: AppSizeExt.of.majorScale(4),
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
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.18),
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
                            .setActions(
                                [const Icon(Icons.chevron_right)]).setOnTap(
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

  void _buildDialogChangeGroupName(BuildContext context, String groupName) {
    AppDialogRequestWidget()
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setTopWidget(AppTextTitleLargeWidget()
            .setText(R.strings.editGroup)
            .build(context))
        .setTextField(
          BlocProvider(
            create: (_) => getIt<GroupEditNameFormBloc>(),
            child: Builder(
              builder: (context) {
                return AppTextFieldWidget()
                    .setBloc(context.read<GroupEditNameFormBloc>().groupName
                      ..updateInitialValue(groupName))
                    .setLabelText(R.strings.groupName)
                    .build(context);
              },
            ),
          ),
        )
        .buildDialog(context)
        .show();
  }
}

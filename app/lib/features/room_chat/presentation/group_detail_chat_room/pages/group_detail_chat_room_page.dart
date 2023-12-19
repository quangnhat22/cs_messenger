import 'package:app/components/features/button/icon_button_with_text_widget.dart';
import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
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
import 'package:app/features/room_chat/presentation/group_detail_chat_room/controllers/edit_group/edit_group_cubit.dart';
import 'package:app/features/room_chat/presentation/group_detail_chat_room/controllers/group_edit_name_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

@RoutePage()
class GroupDetailChatRoomPage extends StatelessWidget {
  const GroupDetailChatRoomPage(
      {super.key, required this.groupId, required this.chatRoomId});

  final String groupId;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GroupEditNameFormBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<EditGroupCubit>(),
        ),
      ],
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget().setTextTitle('').build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<EditGroupCubit, EditGroupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await _showDialogChangeGroupImage(context);
                  },
                  child: AppAvatarCircleWidget()
                      .setSize(AppAvatarSize.extraExtraLarge)
                      //TODO: set url
                      .setUrl(
                          'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zNF9mdWxsX2JvZHlfM2RfYXZhdGFyXzNkX3JlbmRlcl9vZl9hX2J1c2luZXNzd19jOWYzODYxYy1lZTYzLTQxOGYtOThmNC02MWJkNGM3OGE1YTZfMS5wbmc.png')
                      .build(context),
                ),
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
                      text: R.strings.information,
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
                          .setText(R.strings.moreAction)
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
                          .withOpacity(0.36),
                      child: Column(
                        children: <Widget>[
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.image_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.seePictureVideosFiles)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setActions(
                                  [const Icon(Icons.chevron_right)]).setOnTap(
                            () {
                              getIt<AppRouter>()
                                  .push(RoomChatMediaRoute(roomId: chatRoomId));
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
                                  .setText(R.strings.leaveGroup)
                                  .setTextStyle(TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ))
                                  .build(context))
                              .setOnTap(() => _buildDialogLeaveGroup(context))
                              .setHasBottomBorderRadius(true)
                              .build(context)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDialogChangeGroupImage(BuildContext context) async {
    final assetEntity = await showDialog<AssetEntity?>(
      context: context,
      builder: (_) {
        return const AppDialogImagePickerWidget();
      },
    );

    final file = await assetEntity?.file;

    if (file?.path != null && context.mounted) {
      context
          .read<EditGroupCubit>()
          .changeGroupAvatar(groupId: groupId, avatar: file!.path);
    }
  }

  void _buildDialogChangeGroupName(BuildContext context, String groupName) {
    final groupNameFormBloc = context.read<GroupEditNameFormBloc>().groupName;
    AppDialogRequestWidget()
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setTopWidget(AppTextTitleLargeWidget()
            .setText(R.strings.editGroup)
            .build(context))
        .setTextField(
          Builder(
            builder: (context) {
              return AppTextFieldWidget()
                  .setBloc(groupNameFormBloc..updateInitialValue(groupName))
                  .setLabelText(R.strings.groupName)
                  .build(context);
            },
          ),
        )
        .setOnPositive(() {
          context.read<EditGroupCubit>().changeGroupName(
                groupId: groupId,
                name: context.read<GroupEditNameFormBloc>().groupName.value,
              );
        })
        .buildDialog(context)
        .show();
  }

  void _buildDialogLeaveGroup(BuildContext context) {
    AppDefaultDialogWidget()
        .setAppDialogType(AppDialogType.confirm)
        .setTitle(R.strings.leaveGroup)
        .setContent(R.strings.doYouWantToLeaveThisGroup)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await context.read<EditGroupCubit>().leaveGroup(groupId);
          await getIt<AppRouter>().pop();
        })
        .buildDialog(context)
        .show();
  }
}

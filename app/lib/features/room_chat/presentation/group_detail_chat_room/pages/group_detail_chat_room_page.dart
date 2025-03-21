import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
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
  const GroupDetailChatRoomPage({super.key, required this.chatRoomId});

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GroupEditNameFormBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<EditGroupCubit>()..initPage(chatRoomId),
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
                AppAvatarCircleWidget()
                    .setSize(AppAvatarSize.extraExtraLarge)
                    .setUrl(state.avatarUrl)
                    .build(context),
                SizedBox(height: AppSizeExt.of.majorScale(5)),
                AppTextHeadlineLargeWidget()
                    .setText(state.name)
                    .setTextAlign(TextAlign.center)
                    .build(context),
                SizedBox(
                  height: AppSizeExt.of.majorScale(5),
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
                          .withOpacity(AppConstants.appOpacityCard),
                      child: Column(
                        children: <Widget>[
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.image_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.seePictureVideosFiles)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setHasBottomBorderRadius(true)
                              .setActions(
                                  [const Icon(Icons.chevron_right)]).setOnTap(
                            () async {
                              await getIt<AppRouter>()
                                  .push(RoomChatMediaRoute(roomId: chatRoomId));
                            },
                          ).build(context),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizeExt.of.majorScale(1),
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
                          .setText(R.strings.information)
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
                          .withOpacity(AppConstants.appOpacityCard),
                      child: Column(
                        children: <Widget>[
                          AppCardBorderWidget()
                              .setLeading(
                                  const Icon(Icons.info_outline_rounded))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.groupInfo)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setOnTap(() async {
                            if (state.groupId != null &&
                                state.chatRoomId != null) {
                              await getIt<AppRouter>().push(GroupInfoRoute(
                                  groupId: state.groupId!,
                                  chatRoomId: chatRoomId));
                            }
                          }).build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.camera_alt_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.updateAvatar)
                                  .build(context))
                              .setIsShowBottomDivider(true)
                              .setOnTap(() async =>
                                  await _showDialogChangeGroupImage(context))
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.edit_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.changeGroupName)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setOnTap(() => _buildDialogChangeGroupName(
                                  context, state.name ?? ''))
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.groups_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.members)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setOnTap(() async {
                            if (state.groupId != null) {
                              await getIt<AppRouter>().push(
                                  GroupMemberRoute(groupId: state.groupId!));
                            }
                          }).build(context),
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
                              .setHasBottomBorderRadius(true)
                              .setOnTap(() => _buildDialogLeaveGroup(context))
                              .build(context)
                        ],
                      ),
                    ),
                  ],
                ),
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
      context.read<EditGroupCubit>().changeGroupAvatar(avatar: file!.path);
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
          await context.read<EditGroupCubit>().leaveGroup();
          if (context.mounted) {
            await context.router.navigate(const HomeRoute());
          }
        })
        .buildDialog(context)
        .show();
  }
}

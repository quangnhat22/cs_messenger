import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/personal_detail_chat_room/controllers/personal_chat_room_info/personal_chat_room_info_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class PersonalDetailChatRoomPage extends StatelessWidget {
  const PersonalDetailChatRoomPage({
    super.key,
    required this.chatRoomId,
  });

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PersonalChatRoomInfoCubit>()..initPage(chatRoomId),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget().setTextTitle('').build(context))
          .setBackgroundColor(Theme.of(context).colorScheme.surface)
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<PersonalChatRoomInfoCubit, PersonalChatRoomInfoState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
            child: Column(
              children: <Widget>[
                AppAvatarCircleWidget()
                    .setSize(AppAvatarSize.extraExtraLarge)
                    .setUrl(state.avatar)
                    .build(context),
                SizedBox(height: AppSizeExt.of.majorScale(6)),
                AppTextHeadlineSmallWidget()
                    .setText(state.name)
                    .setTextAlign(TextAlign.center)
                    .setTextOverFlow(TextOverflow.ellipsis)
                    .setMaxLines(2)
                    .build(context),
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
                              .setHasBottomBorderRadius(true)
                              .setActions(
                                  [const Icon(Icons.chevron_right)]).setOnTap(
                            () async {
                              if (state.chatRoomId != null) {
                                await getIt<AppRouter>().push(
                                    RoomChatMediaRoute(
                                        roomId: state.chatRoomId!));
                              }
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
                          .withOpacity(0.36),
                      child: Column(
                        children: <Widget>[
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.person_outline))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.seeProfile)
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setActions(
                                  [const Icon(Icons.chevron_right)]).setOnTap(
                            () async {
                              if (state.friendId != null) {
                                await getIt<AppRouter>().push(
                                    FriendInfoRoute(userId: state.friendId!));
                              }
                            },
                          ).build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.group_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings
                                      .createGroupWith(state.name ?? '-'))
                                  .build(context))
                              .setHasTopBorderRadius(true)
                              .setIsShowBottomDivider(true)
                              .setOnTap(() => _onCreateGroupWithYourFriend(
                                  context, state.name ?? ''))
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(Icon(
                                Icons.remove_circle_outline,
                                color: Theme.of(context).colorScheme.error,
                              ))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.deleteFriend)
                                  .setTextStyle(TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ))
                                  .build(context))
                              .setOnTap(() => _onDeleteFriend(context))
                              .setIsShowBottomDivider(true)
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(Icon(
                                Icons.block_outlined,
                                color: Theme.of(context).colorScheme.error,
                              ))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText(R.strings.block)
                                  .setTextStyle(TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ))
                                  .build(context))
                              .setHasBottomBorderRadius(true)
                              .setOnTap(() => _onBlockFriend(context))
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

  void _onDeleteFriend(BuildContext context) {
    _showConfirmDialog(context, R.strings.doYouWantUnFriend, () async {
      await context.read<PersonalChatRoomInfoCubit>().deleteFriend();
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      AppSnackBarWidget()
          .setLabelText(R.strings.unFriendSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
    });
  }

  void _onBlockFriend(BuildContext context) {
    _showConfirmDialog(context, R.strings.areYouSureBlockThisUser, () async {
      await context.read<PersonalChatRoomInfoCubit>().blockFriend();
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      AppSnackBarWidget()
          .setLabelText(R.strings.blockSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
    });
  }

  void _onCreateGroupWithYourFriend(BuildContext context, String name) {
    _showConfirmDialog(context, R.strings.createGroupWith(name), () async {
      await context
          .read<PersonalChatRoomInfoCubit>()
          .createGroupWithYourFriend();
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      AppSnackBarWidget()
          .setLabelText(R.strings.createGroupSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
    });
  }

  void _showConfirmDialog(
      BuildContext context, String title, void Function()? onPositive) {
    AppDefaultDialogWidget()
        .setTitle(R.strings.confirm)
        .setContent(title)
        .setAppDialogType(AppDialogType.confirm)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(onPositive)
        .buildDialog(context)
        .show();
  }
}

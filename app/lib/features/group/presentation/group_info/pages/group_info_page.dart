import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_info/controllers/cubit_group_info/group_info_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@RoutePage()
class GroupInfoPage extends StatelessWidget {
  const GroupInfoPage({
    super.key,
    required this.groupId,
    required this.chatRoomId,
  });

  final String groupId;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GroupInfoCubit>()..initPage(groupId, chatRoomId),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle('')
              .setActions([_appBarActions(context)]).build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _appBarActions(BuildContext context) {
    return BlocBuilder<GroupInfoCubit, GroupInfoState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                if (state.chatRoomId != null) {
                  await getIt<AppRouter>()
                      .navigate(VideoCallRoute(chatRoomId: state.chatRoomId!));
                }
              },
              icon: const Icon(Icons.phone_outlined),
            ),
            IconButton(
              onPressed: () async {
                if (state.chatRoomId != null) {
                  await getIt<AppRouter>()
                      .navigate(ChatRoute(roomId: state.chatRoomId!));
                }
              },
              icon: const Icon(Icons.message_outlined),
            ),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<GroupInfoCubit, GroupInfoState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
            child: Column(
              children: <Widget>[
                AppAvatarCircleWidget()
                    .setSize(AppAvatarSize.extraLarge)
                    .setUrl(state.avatar)
                    .build(context),
                SizedBox(height: AppSizeExt.of.majorScale(8)),
                AppTextTitleLargeWidget().setText(state.name).build(context),
                SizedBox(height: AppSizeExt.of.majorScale(8)),
                Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(AppConstants.appOpacityCard),
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
                                  .setText(state.numberOfMembers.toString())
                                  .setColor(
                                      Theme.of(context).colorScheme.primary)
                                  .build(context),
                              SizedBox(height: AppSizeExt.of.majorScale(2)),
                              AppTextBodyLargeWidget()
                                  .setText(R.strings.members)
                                  .setTextStyle(const TextStyle(
                                      fontWeight: FontWeight.bold))
                                  .setColor(
                                      Theme.of(context).colorScheme.primary)
                                  .build(context),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSizeExt.of.majorScale(15),
                          child: const VerticalDivider(),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppTextBodyLargeWidget()
                                  .setText(DateTimeExt.dateTimeToDisplay(
                                      dateTime: state.createdAt))
                                  .setColor(
                                      Theme.of(context).colorScheme.tertiary)
                                  .build(context),
                              SizedBox(height: AppSizeExt.of.majorScale(2)),
                              AppTextBodyLargeWidget()
                                  .setText(R.strings.createdDate)
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
                SizedBox(height: AppSizeExt.of.majorScale(8)),
                Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.36),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizeExt.of.majorPaddingScale(1)),
                    child: Column(
                      children: <Widget>[
                        AppCardBorderWidget()
                            .setLeading(const Icon(Icons.person_outline))
                            .setTitle(AppTextBodyLargeWidget()
                                .setText(R.strings.createdBy)
                                .build(context))
                            .setSubtitle(AppTextBodyMediumWidget()
                                .setText(state.userCreate?.name)
                                .build(context))
                            .build(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

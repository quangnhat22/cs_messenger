import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/friend_info/controllers/cubit_friend_info/friend_info_cubit.dart';
import 'package:app/features/friend/presentation/friend_info/widgets/friend_info_action_button_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utilities/utilities.dart';

import '../../../../../components/main/avatar/app_avatar_base_builder.dart';

@RoutePage()
class FriendInfoPage extends StatelessWidget {
  const FriendInfoPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FriendInfoCubit>()..initPage(userId),
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget().setTextTitle("").setActions([
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.phone_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_outlined),
            ),
          ]).build(context))
          .setBackgroundColor(Theme.of(context).colorScheme.surfaceVariant)
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<FriendInfoCubit, FriendInfoState>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
              child: Column(
                children: <Widget>[
                  AppAvatarCircleWidget()
                      .setSize(AppAvatarSize.extraLarge)
                      .setUrl(state.userInfo?.avatar)
                      .build(context),
                  SizedBox(height: AppSizeExt.of.majorScale(4)),
                  AppTextTitleLargeWidget()
                      .setText(state.userInfo?.name)
                      .build(context),
                  SizedBox(height: AppSizeExt.of.majorScale(4)),
                  Card(
                    elevation: 0,
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
                                    .setText(
                                        state.userInfo?.friendCommon.toString())
                                    .setColor(
                                        Theme.of(context).colorScheme.primary)
                                    .build(context),
                                SizedBox(height: AppSizeExt.of.majorScale(2)),
                                AppTextBodyLargeWidget()
                                    .setText('Bạn chung')
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
                                    .setText(
                                        state.userInfo?.groupCommon.toString())
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
                    elevation: 0,
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
                                  .setText(state.userInfo?.phone)
                                  .build(context))
                              .setIsShowBottomDivider(true)
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.male_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText('Gender')
                                  .build(context))
                              .setSubtitle(AppTextBodyMediumWidget()
                                  .setText(state.userInfo?.gender?.value)
                                  .build(context))
                              .setIsShowBottomDivider(true)
                              .build(context),
                          AppCardBorderWidget()
                              .setLeading(const Icon(Icons.cake_outlined))
                              .setTitle(AppTextBodyLargeWidget()
                                  .setText('Birthday')
                                  .build(context))
                              .setSubtitle(AppTextBodyMediumWidget()
                                  .setText(DateTimeExt.dateTimeToDisplay(
                                      dateTime: state.userInfo?.birthday))
                                  .build(context))
                              .build(context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizeExt.of.majorScale(4)),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizeExt.of.majorPaddingScale(1)),
                      child: const FriendInfoActionButtonWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

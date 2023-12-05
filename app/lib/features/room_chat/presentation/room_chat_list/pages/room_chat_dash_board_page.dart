import 'package:app/components/features/appBar/sliver_search_app_bar_widget.dart';
import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RoomChatDashBoardPage extends StatelessWidget {
  const RoomChatDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNestedScrollPageWidget()
        .setSliverAppBar(const SliverSearchAppBarWidget())
        .setBody(_body(context))
        .build(context);
  }

  Widget _body(BuildContext context) {
    return Ink(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizeExt.of.majorPaddingScale(1),
          vertical: AppSizeExt.of.majorPaddingScale(1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppCardChatRoomWidget()
              .setLeading(const CircleAvatar(radius: 24))
              .setTitle(
                  AppTextTitleMediumWidget().setText('123').build(context))
              .setSubtitle(AppTextLabelMediumWidget()
                  .setText(
                      '123jsndjsnjdnsjndjsndjsndjnsjdnsjdnjsndjsndsndjsndjnsjdnsjndjsndjnsjdnsjndjsndjnsjdnjsndjsnjdnsjdnjsndjsndjsnjdnsjndj')
                  .setMaxLines(2)
                  .setTextOverFlow(TextOverflow.ellipsis)
                  .build(context))
              .setHasTopBorderRadius(true)
              .setIsShowBottomDivider(true)
              .setActions([
            AppTextLabelSmallWidget().setText('4:30 PM').build(context),
            SizedBox(
              height: AppSizeExt.of.majorScale(2),
            ),
            AppDotIndicatorWidget(
              height: AppSizeExt.of.majorScale(5),
              width: AppSizeExt.of.majorScale(5),
              isActive: true,
              child: AppTextLabelSmallWidget()
                  .setText('1')
                  .setColor(Theme.of(context).colorScheme.background)
                  .build(context),
            )
          ]).setOnTap(() {
            getIt<AppRouter>().push(const ChatRoute());
          }).build(context),
          AppCardChatRoomWidget()
              .setLeading(const CircleAvatar(radius: 24))
              .setTitle(
                  AppTextTitleMediumWidget().setText('123').build(context))
              .setSubtitle(AppTextLabelMediumWidget()
                  .setText(
                      '123jsndjsnjdnsjndjsndjsndjnsjdnsjdnjsndjsndsndjsndjnsjdnsjndjsndjnsjdnsjndjsndjnsjdnjsndjsnjdnsjdnjsndjsndjsnjdnsjndj')
                  .setMaxLines(2)
                  .setTextOverFlow(TextOverflow.ellipsis)
                  .build(context))
              .setIsShowBottomDivider(true)
              .setActions([
                AppTextLabelSmallWidget().setText('4:30 PM').build(context),
                SizedBox(
                  height: AppSizeExt.of.majorScale(2),
                ),
                AppDotIndicatorWidget(
                  height: AppSizeExt.of.majorScale(5),
                  width: AppSizeExt.of.majorScale(5),
                  isActive: true,
                  child: AppTextLabelSmallWidget()
                      .setText('1')
                      .setColor(Theme.of(context).colorScheme.background)
                      .build(context),
                )
              ])
              .setOnTap(() {})
              .build(context),
          // const Expanded(child: ListFriendWidget())
        ],
      ),
    );
  }
}

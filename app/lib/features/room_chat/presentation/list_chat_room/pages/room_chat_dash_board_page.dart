import 'package:app/components/features/appBar/sliver_search_app_bar_widget.dart';
import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/features/slide/app_dot_indicator_widget.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/room_chat/presentation/list_chat_room/controllers/list_chat_room_cubit.dart';
import 'package:app/features/room_chat/presentation/list_chat_room/widgets/room_chat_subtitle_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class RoomChatDashBoardPage extends StatelessWidget {
  const RoomChatDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListChatRoomCubit>(),
      child: AppNestedScrollPageWidget()
          .setSliverAppBar(const SliverSearchAppBarWidget())
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Ink(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizeExt.of.majorPaddingScale(1),
          vertical: AppSizeExt.of.majorPaddingScale(1)),
      child: AppListWidget<ChatRoomModel, AppListViewState<ChatRoomModel>,
          ListChatRoomCubit>(
        physics: const BouncingScrollPhysics(),
        childWidget: _buildCardChatRoomItem,
      ),
    );
  }

  Widget _buildCardChatRoomItem(
      BuildContext context, ChatRoomModel model, int index) {
    return AppCardChatRoomWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(model.avatar)
            .setSize(AppAvatarSize.medium)
            .build(context))
        .setTitle(AppTextTitleMediumWidget().setText(model.name).build(context))
        .setSubtitle(RoomChatSubTitleWidget(
            author: model.message?.author, content: model.message?.content))
        .setHasTopBorderRadius(true)
        .setIsShowBottomDivider(true)
        .setActions([
      AppTextLabelSmallWidget()
          .setText(MessageUtils.getVerboseDateTimeRepresentation(
              model.message!.createdAt!))
          .build(context),
      if (model.isCalling != true && model.isHasNewMessage)
        SizedBox(
          height: AppSizeExt.of.majorScale(2),
        ),
      if (model.isCalling != true && model.isHasNewMessage)
        AppDotIndicatorWidget(
          height: AppSizeExt.of.majorScale(3),
          width: AppSizeExt.of.majorScale(3),
          isActive: true,
        ),
      if (model.isCalling == true)
        AppButtonOutlineWidget()
            .setAppButtonSize(AppButtonSize.small)
            .setButtonText(R.strings.join)
            .setTextStyle(TextStyle(color: AppColorPalette.of.greenColor[5]))
            .setBorderColor(AppColorPalette.of.greenColor[3])
            .setOnPressed(() async {
          await getIt<AppRouter>().push(VideoCallRoute(chatRoomId: model.id));
        }).build(context),
    ]).setOnTap(() async {
      context.read<ListChatRoomCubit>().removeNewMessageStatus(model.id);
      await getIt<AppRouter>().push(ChatRoute(roomId: model.id));
    }).build(context);
  }
}

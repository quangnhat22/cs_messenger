import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/video_call/presentation/controllers/members/list_video_member_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:resources/resources.dart';

class ListMemberView extends StatefulWidget {
  const ListMemberView({super.key, required this.chatRoomId});

  final String chatRoomId;

  @override
  State<ListMemberView> createState() => _ListMemberViewState();
}

class _ListMemberViewState extends State<ListMemberView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListVideoMemberCubit>()
        ..getListMemberVideoCall(widget.chatRoomId),
      child: BlocBuilder<ListVideoMemberCubit, ListVideoMemberState>(
        builder: (context, state) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const MaterialClassicHeader(),
            footer: const ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            controller: _refreshController,
            onRefresh: () async {
              await context
                  .read<ListVideoMemberCubit>()
                  .refreshMemberVideoCall();

              _refreshController.refreshCompleted();
            },
            child: state.isError
                ? _retry(context)
                : _main(context, state.listMembers, state.isLoading),
          );
        },
      ),
    );
  }

  Widget _main(BuildContext context, List<UserModel> members, bool isLoading) {
    return isLoading
        ? const ListSkeleton()
        : members.isEmpty
            ? Center(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: R.svgs.icNoData.svg(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: members.length,
                itemBuilder: (context, index) =>
                    _itemMemberWidget(context, index, members),
              );
  }

  Widget _retry(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(6),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              R.svgs.icErrorList.svg(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width * 0.3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizeExt.of.majorPaddingScale(5),
                ),
                child: AppTextHeadlineSmallWidget()
                    .setText(R.strings.someThingWrong)
                    .setColor(Theme.of(context).colorScheme.tertiary)
                    .setTextAlign(TextAlign.center)
                    .build(context),
              ),
              AppButtonOutlineWidget()
                  .setButtonText(R.strings.retry)
                  .setBorderColor(Theme.of(context).colorScheme.error)
                  .setTextStyle(
                      TextStyle(color: Theme.of(context).colorScheme.error))
                  .setOnPressed(() async => await context
                      .read<ListVideoMemberCubit>()
                      .refreshMemberVideoCall())
                  .build(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMemberWidget(
      BuildContext context, int index, List<UserModel> members) {
    return AppCardBorderWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(members[index].avatar)
            .setSize(AppAvatarSize.medium)
            .build(context))
        .setTitle(AppTextTitleMediumWidget()
            .setText(members[index].name)
            .build(context))
        .setSubtitle(AppTextBodyMediumWidget()
            .setText("${R.strings.email}: ${members[index].email}")
            .build(context))
        .setHasTopBorderRadius(index == 0)
        .setIsShowBottomDivider(true)
        .build(context);
  }
}

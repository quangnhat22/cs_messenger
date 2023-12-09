import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/invite_friend/controllers/cubit/list_selected_friend_cubit.dart';
import 'package:app/features/friend/presentation/invite_friend/controllers/invite_list_friend_cubit.dart';
import 'package:app/features/friend/presentation/invite_friend/widgets/list_friend_invite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class InviteFriendPage extends StatelessWidget {
  const InviteFriendPage({
    super.key,
    this.groupId,
  });

  final String? groupId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<InviteListFriendCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ListSelectedFriendCubit>(),
        ),
      ],
      child: AppMainPageWidget()
          .setBody(_body(context))
          .setBackgroundColor(Colors.transparent)
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<ListSelectedFriendCubit, ListSelectedFriendState>(
      buildWhen: (previous, current) =>
          previous.selectedMembers.length != current.selectedMembers.length,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.selectedMembers.isNotEmpty)
                AppTextTitleLargeWidget()
                    .setText(
                        "${R.strings.selected} (${state.selectedMembers.length})")
                    .setTextStyle(TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(context),
              if (state.selectedMembers.isNotEmpty)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  margin: EdgeInsets.symmetric(
                    vertical: AppSizeExt.of.majorPaddingScale(2),
                  ),
                  height: AppAvatarSize.medium.value,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AppAvatarCircleWidget()
                          .setUrl(state.selectedMembers[index].avatar)
                          .setSize(AppAvatarSize.medium)
                          .build(context);
                    },
                    itemCount: state.selectedMembers.length,
                  ),
                ),
              if (state.selectedMembers.isNotEmpty) const Divider(),
              ListFriendInviteWidget(listFriendSelected: state.selectedMembers),
              if (state.selectedMembers.isNotEmpty)
                AppButtonFilledWidget()
                    .setButtonText(R.strings.done)
                    .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.background))
                    .setOnPressed(() {
                  Navigator.pop(context, state.selectedMembers);
                }).build(context),
            ],
          ),
        );
      },
    );
  }
}

import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/search/presentation/controllers/bloc/search_bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class SearchUserItemWidget extends StatelessWidget {
  const SearchUserItemWidget({super.key, this.user});

  final UserModel? user;

  void _handleAddFriendButton(BuildContext context) {
    AppDialogRequestWidget()
        .setTopWidget(AppAvatarCircleWidget()
            .setUrl(user?.avatar ?? '')
            .setSize(AppAvatarSize.extraExtraLarge)
            .build(context))
        .setTitle(user?.name)
        .setIsHaveCloseIcon(true)
        .setPositiveText(R.strings.addFriend)
        .setOnPositive(() {
          if (user?.id != null) {
            context
                .read<SearchBloc>()
                .add(SearchSendFriendRequest(userId: user!.id));
            Navigator.of(context).pop();
          }
        })
        .buildDialog(context)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return AppCardBorderWidget()
        .setLeading(AppAvatarCircleWidget()
            .setUrl(user?.avatar ?? '')
            .setSize(AppAvatarSize.large)
            .build(context))
        .setTitle(AppTextBodyLargeWidget().setText(user?.name).build(context))
        .setSubtitle(
            AppTextBodyMediumWidget().setText(user?.email).build(context))
        .setOnTap((user?.relation?.relation == RelationType.stranger)
            ? null
            : () async {
                if (user?.id != null) {
                  await getIt<AppRouter>()
                      .push(FriendInfoRoute(userId: user!.id));
                }
              })
        .setActions([
      if (user?.relation?.relation == RelationType.stranger)
        AppButtonOutlineWidget()
            .setAppButtonSize(AppButtonSize.medium)
            .setButtonText(R.strings.addFriend)
            .setBorderColor(Theme.of(context).colorScheme.primary)
            .setOnPressed(() => _handleAddFriendButton(context))
            .build(context),
      if (user?.relation?.relation == RelationType.requested)
        AppButtonOutlineWidget()
            .setAppButtonSize(AppButtonSize.medium)
            .setButtonText(R.strings.receive)
            .build(context),
      if (user?.relation?.relation == RelationType.requesting)
        AppButtonOutlineWidget()
            .setAppButtonSize(AppButtonSize.medium)
            .setButtonText(R.strings.sent)
            .build(context)
    ]).build(context);
  }
}

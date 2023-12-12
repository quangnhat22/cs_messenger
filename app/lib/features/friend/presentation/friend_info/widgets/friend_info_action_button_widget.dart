import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/friend/presentation/friend_info/controllers/cubit_friend_info/friend_info_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class FriendInfoActionButtonWidget extends StatelessWidget {
  const FriendInfoActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendInfoCubit, FriendInfoState>(
      buildWhen: (prev, current) => prev.userInfo?.id != current.userInfo?.id,
      builder: (context, state) {
        if (state.userInfo?.id == null) {
          return const SizedBox();
        }
        switch (state.userInfo?.relation?.relation) {
          case RelationType.friend:
            {
              return Column(
                children: <Widget>[
                  _buildRemoveFriendButton(context, state.userInfo!.id),
                  const Divider(),
                  _buildBlockFriendButton(context, state.userInfo!.id),
                ],
              );
            }
          case RelationType.stranger:
            {
              return _buildAddFriendButton(context, state.userInfo!.id);
            }
          case RelationType.requested:
            {
              return _buildAcceptRequestFriendButton(
                  context, state.userInfo!.id);
            }
          case RelationType.requesting:
            {
              return _buildUndoRequestFriendButton(context, state.userInfo!.id);
            }
          default:
            {
              return const SizedBox();
            }
        }
      },
    );
  }

  Widget _buildAddFriendButton(BuildContext context, String? userId) {
    return AppCardBorderWidget()
        .setLeading(Icon(
          Icons.person_add_alt_1_outlined,
          color: Theme.of(context).colorScheme.primary,
        ))
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.addFriend)
            .setColor(Theme.of(context).colorScheme.primary)
            .build(context))
        .setOnTap(() async {
          await context.read<FriendInfoCubit>().addFriend();
        })
        .setIsShowBottomDivider(true)
        .build(context);
  }

  Widget _buildBlockFriendButton(BuildContext context, String userId) {
    return AppCardBorderWidget()
        .setLeading(Icon(
          Icons.block_outlined,
          color: Theme.of(context).colorScheme.error,
        ))
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.block)
            .setColor(Theme.of(context).colorScheme.error)
            .build(context))
        .setOnTap(
          () => _showConfirmDialog(context, R.strings.areYouSureBlockThisUser,
              () async {
            await context.read<FriendInfoCubit>().blockFriend();
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          }),
        )
        .build(context);
  }

  Widget _buildRemoveFriendButton(BuildContext context, String userId) {
    return AppCardBorderWidget()
        .setLeading(Icon(
          Icons.group_remove_outlined,
          color: Theme.of(context).colorScheme.error,
        ))
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.removeFriend)
            .setColor(Theme.of(context).colorScheme.error)
            .build(context))
        .setOnTap(
          () => _showConfirmDialog(context, R.strings.doYouWantUnFriend,
              () async {
            await context.read<FriendInfoCubit>().deleteFriend();
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          }),
        )
        .build(context);
  }

  Widget _buildUndoRequestFriendButton(BuildContext context, String userId) {
    return AppCardBorderWidget()
        .setLeading(Icon(
          Icons.undo_outlined,
          color: Theme.of(context).colorScheme.tertiary,
        ))
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.undoFriendRequest)
            .setTextStyle(
                TextStyle(color: Theme.of(context).colorScheme.tertiary))
            .setColor(Theme.of(context).colorScheme.tertiary)
            .build(context))
        .setOnTap(() async =>
            await getIt<AppRouter>().replace(const FriendRequestRoute()))
        .build(context);
  }

  Widget _buildAcceptRequestFriendButton(BuildContext context, String userId) {
    return AppCardBorderWidget()
        .setLeading(Icon(
          Icons.person_outline,
          color: Theme.of(context).colorScheme.primary,
        ))
        .setTitle(AppTextBodyLargeWidget()
            .setText(R.strings.acceptOrReject)
            .setTextStyle(
                TextStyle(color: Theme.of(context).colorScheme.primary))
            .build(context))
        .setOnTap(() async =>
            await getIt<AppRouter>().replace(const FriendRequestRoute()))
        .build(context);
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

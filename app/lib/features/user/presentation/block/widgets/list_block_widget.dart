import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/app_list_view_widget.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/user/presentation/block/controllers/block_list_cubit.dart';
import 'package:app/features/user/presentation/block/controllers/cubit_action_block/action_block_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class ListBlockWidget extends StatelessWidget {
  const ListBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppListWidget<UserModel, AppListViewState<UserModel>,
        GetListBlockCubit>(
      physics: const BouncingScrollPhysics(),
      childWidget: _buildCardBlockItem,
    );
  }

  Widget _buildCardBlockItem(BuildContext context, UserModel user, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizeExt.of.majorPaddingScale(3 / 4),
        horizontal: AppSizeExt.of.majorPaddingScale(2),
      ),
      child: AppCardWidget()
          .setLeading(AppAvatarCircleWidget()
              .setUrl(user.avatar)
              .setSize(AppAvatarSize.medium)
              .build(context))
          .setTitle(
              AppTextTitleMediumWidget().setText(user.name).build(context))
          .setSubtitle(AppTextBodyMediumWidget()
              .setText("${R.strings.email}: ${user.email}")
              .build(context))
          .setActions([
            AppButtonOutlineWidget()
                .setButtonText(R.strings.unBlock)
                .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.tertiary))
                .setBorderColor(Theme.of(context).colorScheme.tertiary)
                .setOnPressed(() async =>
                    await _handleBlockItemButtonTap(context, user.id))
                .build(context)
          ])
          .setOnTap(() => _handleBlockItemButtonTap(context, user.id))
          .build(context),
    );
  }

  Future<void> _handleBlockItemButtonTap(
      BuildContext context, String userId) async {
    AppDefaultDialogWidget()
        .setTitle(R.strings.confirm)
        .setContent(R.strings.doYouWantUnBlockThisUser)
        .setAppDialogType(AppDialogType.confirm)
        .setNegativeText(R.strings.close)
        .setPositiveText(R.strings.confirm)
        .setOnPositive(() async {
          await context.read<ActionBlockCubit>().unBlockUser(userId);
          if (context.mounted) {
            await context.read<GetListBlockCubit>().onRefreshCall();
          }
        })
        .buildDialog(AppKeys.navigatorKey.currentContext!)
        .show();
  }
}

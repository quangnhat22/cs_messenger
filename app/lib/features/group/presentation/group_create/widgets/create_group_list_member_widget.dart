import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/card/app_card_base_builder.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_create/controllers/cubit_form_create_group/create_group_form_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class CreateGroupListMemberWidget extends StatelessWidget {
  const CreateGroupListMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupFormCubit, CreateGroupFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (state.members != null && state.members!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(3),
                  vertical: AppSizeExt.of.majorPaddingScale(2),
                ),
                child: AppTextTitleMediumWidget()
                    .setText(
                        "${R.strings.members} (${state.members?.length ?? 0})")
                    .setTextStyle(TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ))
                    .build(context),
              ),
            if (state.members != null && state.members!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) =>
                    _buildCardItem(context, index, state.members![index]),
              )
          ],
        );
      },
    );
  }

  Widget _buildCardItem(BuildContext context, int index, UserModel user) {
    return AppCardBorderWidget()
        .setTitle(AppTextBodyLargeWidget().setText(user.name).build(context))
        .setLeading(AppAvatarCircleWidget()
            .setUrl(user.avatar)
            .setSize(AppAvatarSize.medium)
            .build(context))
        .setActions(<Widget>[]).build(context);
  }
}

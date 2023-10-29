import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_dashboard/controllers/cubit_list_group.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

class GroupListLabelWidget extends StatelessWidget {
  const GroupListLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListGroupCubit, AppListViewState<GroupModel>>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizeExt.of.majorPaddingScale(2),
            vertical: AppSizeExt.of.majorPaddingScale(3),
          ),
          child: AppTextTitleMediumWidget()
              .setText("${R.strings.groups} (${state.total.toString()})")
              .setTextStyle(TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ))
              .build(context),
        );
      },
    );
  }
}

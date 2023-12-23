import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/invite_friend/pages/inivite_friend_page.dart';
import 'package:app/features/group/presentation/group_create/controllers/create_group_name_form.cubit.dart';
import 'package:app/features/group/presentation/group_create/controllers/cubit_form_create_group/create_group_form_cubit.dart';
import 'package:app/features/group/presentation/group_create/widgets/create_group_image_widget.dart';
import 'package:app/features/group/presentation/group_create/widgets/create_group_list_member_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

@RoutePage()
class GroupCreatePage extends StatelessWidget {
  const GroupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CreateGroupNameFormBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<CreateGroupFormCubit>(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          AppDefaultDialogWidget()
              .setTitle(R.strings.confirm)
              .setContent(R.strings.doYouWantToExit)
              .setAppDialogType(AppDialogType.confirm)
              .setNegativeText(R.strings.close)
              .setPositiveText(R.strings.confirm)
              .setOnPositive(() async {
                Navigator.of(context).pop();
              })
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
          return false;
        },
        child: AppMainPageWidget()
            .setAppBar(AppBarWidget()
                .setTextTitle(R.strings.createNewGroup)
                .build(context))
            .setBody(_body(context))
            .setFloatActionButton(_fabAddMemberButton(context))
            .build(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizeExt.of.majorScale(2)),
                  const CreateGroupImageWidget(),
                  SizedBox(height: AppSizeExt.of.majorScale(5)),
                  Builder(
                    builder: (context) {
                      return AppTextFieldWidget()
                          .setBloc(
                              context.read<CreateGroupNameFormBloc>().groupName)
                          .setOnChanged((value) {
                            context
                                .read<CreateGroupFormCubit>()
                                .groupNameChanged(value);
                          })
                          .setIsRequired(true)
                          .setKeyboardType(TextInputType.text)
                          .setAutoFillHints([AutofillHints.name])
                          .setLabelText(R.strings.groupName)
                          .build(context);
                    },
                  ),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(4),
                  ),
                  const CreateGroupListMemberWidget(),
                ],
              ),
            ),
          ),
        ),
        Material(
          elevation: AppConstants.numberElevationContainer,
          child: Padding(
            padding: EdgeInsets.all(AppSizeExt.of.majorScale(4)),
            child: BlocBuilder<CreateGroupFormCubit, CreateGroupFormState>(
              builder: (context, state) {
                return AppButtonFilledWidget()
                    .setButtonText(R.strings.create.toUpperCase())
                    .setAppButtonSize(AppButtonSize.large)
                    .setBackgroundColor(Theme.of(context).colorScheme.primary)
                    .setTextStyle(TextStyle(
                        color: Theme.of(context).colorScheme.background))
                    .setOnPressed(state.groupName.isNotEmpty
                        ? () async {
                            await context
                                .read<CreateGroupFormCubit>()
                                .createNewGroup();
                            if (context.mounted) {
                              Navigator.of(context).pop(true);
                            }
                          }
                        : null)
                    .build(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _fabAddMemberButton(BuildContext context) {
    return BlocBuilder<CreateGroupFormCubit, CreateGroupFormState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            bottom: AppSizeExt.of.majorScale(20),
          ),
          child: FloatingActionButton(
            onPressed: () async =>
                await _showBottomSheetAddMember(context, state.members ?? []),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _showBottomSheetAddMember(
      BuildContext context, List<UserModel> filterMember) async {
    await showModalBottomSheet<List<UserModel>>(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: context,
      builder: (context) {
        return InviteFriendPage(listFilterFriend: filterMember);
      },
    ).then((result) async {
      if (result != null) {
        context.read<CreateGroupFormCubit>().friendInvitedChanged(result);
      }
    });
  }
}

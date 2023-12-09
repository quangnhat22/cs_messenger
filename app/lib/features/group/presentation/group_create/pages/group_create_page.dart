import 'package:app/components/main/appBar/app_bar_base_builder.dart';
import 'package:app/components/main/page/app_main_page_base_builder.dart';
import 'package:app/components/main/textField/app_field_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/friend/presentation/invite_friend/pages/inivite_friend_page.dart';
import 'package:app/features/group/presentation/group_create/controllers/create_group_name_form.cubit.dart';
import 'package:app/features/group/presentation/group_create/controllers/cubit_form_create_group/create_group_form_cubit.dart';
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
      child: AppMainPageWidget()
          .setAppBar(AppBarWidget()
              .setTextTitle(R.strings.createNewGroup)
              .build(context))
          .setBody(_body(context))
          .build(context),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(5)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: AppSizeExt.of.majorScale(2),
                ),
                CircleAvatar(
                  radius: AppSizeExt.of.majorScale(14),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: IconButton(
                    onPressed: () {
                      // _showImageDialog(context);
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: AppSizeExt.of.majorScale(9),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizeExt.of.majorScale(5),
                ),
                Builder(
                  builder: (context) {
                    return AppTextFieldWidget()
                        .setBloc(
                            context.read<CreateGroupNameFormBloc>().groupName)
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
        Positioned(
          bottom: 0,
          child: FloatingActionButton(
            onPressed: () async => await _showBottomSheetAddMember(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<void> _showBottomSheetAddMember(BuildContext context) async {
    await showModalBottomSheet<List<UserModel>>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizeExt.of.majorScale(5)),
          topRight: Radius.circular(AppSizeExt.of.majorScale(5)),
        ),
      ),
      context: context,
      builder: (context) {
        return const InviteFriendPage();
      },
    ).then((result) async {
      if (result != null) {
        context.read<CreateGroupFormCubit>().friendInvitedChanged(result);
      }
    });
  }
}

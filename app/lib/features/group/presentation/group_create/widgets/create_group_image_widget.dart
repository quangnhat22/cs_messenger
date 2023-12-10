import 'dart:io';

import 'package:app/components/features/imagePicker/app_dialog_image_picker.dart';
import 'package:app/components/main/avatar/app_avatar_base_builder.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:app/features/group/presentation/group_create/controllers/cubit_form_create_group/create_group_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreateGroupImageWidget extends StatelessWidget {
  const CreateGroupImageWidget({super.key});

  Future<void> _showDialogChangeImage(BuildContext context) async {
    final assetEntity = await showDialog<AssetEntity?>(
      context: context,
      builder: (_) {
        return const AppDialogImagePickerWidget();
      },
    );

    final file = await assetEntity?.file;

    if (file?.path != null && context.mounted) {
      context.read<CreateGroupFormCubit>().groupAvatarChanged(file!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupFormCubit, CreateGroupFormState>(
      builder: (context, state) {
        return state.groupImage != null && state.groupImage!.isNotEmpty
            ? Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: AppAvatarSize.large.value,
                    backgroundImage: Image.file(File(state.groupImage!)).image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AppButtonOutlineWidget()
                        .setPrefixIcon(const Icon(Icons.edit_outlined))
                        .setAppButtonType(AppButtonType.circle)
                        .setAppButtonSize(AppButtonSize.small)
                        .setOnPressed(() {
                      _showDialogChangeImage(context);
                    }).build(context),
                  ),
                ],
              )
            : CircleAvatar(
                radius: AppAvatarSize.large.value,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: IconButton(
                  onPressed: () {
                    _showDialogChangeImage(context);
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: AppSizeExt.of.majorScale(9),
                  ),
                ),
              );
      },
    );
  }
}

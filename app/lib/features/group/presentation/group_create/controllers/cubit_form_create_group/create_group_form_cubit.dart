import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/features/group/domain/usecases/create_new_group_uc.dart';
import 'package:app/service/firebase/upload_file_exts.dart';
import 'package:domain/domain.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part 'create_group_form_state.dart';
part 'create_group_form_cubit.freezed.dart';

@Injectable()
class CreateGroupFormCubit extends Cubit<CreateGroupFormState> {
  late final CreateNewGroupUseCase _createNewGroupUseCase;

  CreateGroupFormCubit(this._createNewGroupUseCase)
      : super(const CreateGroupFormState.initial());

  void friendInvitedChanged(List<UserModel> friends) {
    emit(state.copyWith(members: [...state.members ?? [], ...friends]));
  }

  void removeMember(String userId) {
    emit(state.copyWith(
        members:
            state.members?.where((element) => element.id != userId).toList()));
  }

  void groupAvatarChanged(String url) {
    emit(state.copyWith(groupImage: url));
  }

  void groupNameChanged(String name) {
    emit(state.copyWith(groupName: name));
  }

  Future<void> createNewGroup() async {
    try {
      if (state.groupName.trim().isEmpty) {
        AppSnackBarWidget()
            .setLabelText(R.strings.sendEmailSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.error)
            .showSnackBar();
        return;
      }
      AppLoadingOverlayWidget.show();
      if (state.groupImage != null && state.groupImage!.trim().isNotEmpty) {
        final groupImageUrl = await UploadFileExts.uploadAndDownloadUrlFile(
            state.groupImage!, TypeFile.images.type);
        await _submitCreateNewGroupForm(groupImageNetworkUrl: groupImageUrl);
      } else {
        await _submitCreateNewGroupForm();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> _submitCreateNewGroupForm({String? groupImageNetworkUrl}) async {
    try {
      final param = CreateNewGroupParam(
          name: state.groupName,
          avatar: groupImageNetworkUrl ?? state.groupImage,
          members: state.members?.map((e) => e.id).toList() ?? []);
      await _createNewGroupUseCase.executeObj(request: param);
      AppLoadingOverlayWidget.dismiss();
      AppSnackBarWidget()
          .setLabelText(R.strings.createGroupSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

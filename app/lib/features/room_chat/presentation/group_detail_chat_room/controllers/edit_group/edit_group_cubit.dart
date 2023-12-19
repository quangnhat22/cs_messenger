import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/group/domain/usecases/edit_group_uc.dart';
import 'package:app/features/group/domain/usecases/leave_group_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'edit_group_state.dart';
part 'edit_group_cubit.freezed.dart';

@Injectable()
class EditGroupCubit extends Cubit<EditGroupState> {
  late final EditGroupUseCase _editGroupUseCase;
  late final LeaveGroupUseCase _leaveGroupUseCase;

  EditGroupCubit(this._editGroupUseCase, this._leaveGroupUseCase)
      : super(const EditGroupState.initial());

  Future<void> editGroup(
      {required String groupId, required String name, String? avatar}) async {
    try {
      if (name.trim().isEmpty) {
        return;
      }
      if (avatar != null) {}
      await _editGroupUseCase.executeObj(
          request: EditGroupParam(groupId: groupId, name: name));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<void> leaveGroup(String groupId) async {
    try {
      AppLoadingOverlayWidget.show();
      await _leaveGroupUseCase.executeObj(
          request: LeaveGroupParam(groupId: groupId));
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
        appException: e,
        onError: (e) {
          Logs.e(e);
        },
      ).detected();
    }
  }
}

import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/group/domain/usecases/edit_group_uc.dart';
import 'package:app/features/group/domain/usecases/leave_group_uc.dart';
import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:app/service/firebase/upload_file_exts.dart';
import 'package:domain/domain.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;

  EditGroupCubit(
    this._editGroupUseCase,
    this._leaveGroupUseCase,
    this._getChatRoomDetailInfoUseCase,
  ) : super(const EditGroupState.initial());

  Future<void> initPage(String chatRoomId) async {
    try {
      AppLoadingOverlayWidget.show();
      emit(state.copyWith(chatRoomId: chatRoomId));
      final (groupId, name, image) = await _getChatRoomInfo(chatRoomId);
      emit(state.copyWith(name: name, avatarUrl: image, groupId: groupId));
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<void> refreshPage() async {
    try {
      if (state.chatRoomId != null) {
        final (groupId, name, image) =
            await _getChatRoomInfo(state.chatRoomId!);
        emit(state.copyWith(name: name, avatarUrl: image, groupId: groupId));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<(String?, String?, String?)> _getChatRoomInfo(
      String chatRoomId) async {
    try {
      final chatRoomResponse = await _getChatRoomDetailInfoUseCase.executeObj(
          request: GetChatRoomInfoParam(id: chatRoomId));
      final chatRoomInfo = chatRoomResponse.netData;
      if (chatRoomInfo != null) {
        return (chatRoomInfo.id, chatRoomInfo.name, chatRoomInfo.avatar);
      }
      return (null, null, null);
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> changeGroupName({required String name}) async {
    try {
      if (name.trim().isEmpty && state.groupId == null) {
        return;
      }
      await _editGroupUseCase.executeObj(
          request: EditGroupParam(groupId: state.groupId!, name: name));
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<void> changeGroupAvatar({required String avatar}) async {
    try {
      if (state.groupId == null) {
        return;
      }
      final UploadTask? uploadTask = UploadFileExts.uploadFile(avatar);
      uploadTask!.snapshotEvents.listen(
        (taskSnapShot) => UploadFileExts.handleSnapShot(taskSnapShot).then(
          (path) async {
            if (path != null) {
              await _editGroupUseCase.executeObj(
                  request:
                      EditGroupParam(groupId: state.groupId!, avatar: path));
            }
          },
        ),
      );
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<void> leaveGroup() async {
    try {
      if (state.groupId == null) {
        return;
      }
      AppLoadingOverlayWidget.show();
      await _leaveGroupUseCase.executeObj(
          request: LeaveGroupParam(groupId: state.groupId!));
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

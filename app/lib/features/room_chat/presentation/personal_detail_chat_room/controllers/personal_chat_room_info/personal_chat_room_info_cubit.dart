import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/friend/domain/usecases/delete_friend_uc.dart';
import 'package:app/features/group/domain/usecases/create_new_group_uc.dart';
import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:app/features/user/domain/usecases/block/block_user_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'personal_chat_room_info_state.dart';
part 'personal_chat_room_info_cubit.freezed.dart';

@Injectable()
class PersonalChatRoomInfoCubit extends Cubit<PersonalChatRoomInfoState> {
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;
  late final CreateNewGroupUseCase _createNewGroupUseCase;
  late final DeleteFriendUseCase _deleteFriendUseCase;
  late final BlockUserUseCase _blockUserUseCase;

  PersonalChatRoomInfoCubit(
    this._getChatRoomDetailInfoUseCase,
    this._createNewGroupUseCase,
    this._deleteFriendUseCase,
    this._blockUserUseCase,
  ) : super(const PersonalChatRoomInfoState.initial());

  Future<void> initPage(String chatRoomId) async {
    try {
      AppLoadingOverlayWidget.show();

      await _getChatRoomInfo(chatRoomId);

      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }

  Future<void> _getChatRoomInfo(String chatRoomId) async {
    try {
      final chatRoomResponse = await _getChatRoomDetailInfoUseCase.executeObj(
          request: GetChatRoomInfoParam(id: chatRoomId));
      final chatRoomInfo = chatRoomResponse.netData;
      if (chatRoomInfo != null) {
        emit(state.copyWith(
          chatRoomId: chatRoomInfo.id,
          name: chatRoomInfo.name,
          avatar: chatRoomInfo.avatar,
          friendId: chatRoomInfo.groupId,
        ));
      }
    } on AppException catch (_) {
      rethrow;
    }
  }
}

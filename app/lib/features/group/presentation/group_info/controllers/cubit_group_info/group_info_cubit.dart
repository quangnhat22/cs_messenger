import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/group/domain/usecases/get_list_member_group_uc.dart';
import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_message_chat_room_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'group_info_cubit.freezed.dart';
part 'group_info_state.dart';

@Injectable()
class GroupInfoCubit extends Cubit<GroupInfoState> {
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;
  late final GetListMessageChatRoomUseCase _getListMessageChatRoomUseCase;
  late final GetListMemberGroupUseCase _getListMemberGroupUseCase;

  GroupInfoCubit(
    this._getChatRoomDetailInfoUseCase,
    this._getListMessageChatRoomUseCase,
    this._getListMemberGroupUseCase,
  ) : super(const GroupInfoState.initial());

  Future<void> initPage(String groupId, String chatRoomId) async {
    try {
      AppLoadingOverlayWidget.show();

      final chatRoomResponse = await _getChatRoomDetailInfoUseCase.executeObj(
          request: GetChatRoomInfoParam(id: chatRoomId));
      final listMemberResponse = await _getListMemberGroupUseCase.executeList(
          request: GetListMemberGroupParam(groupId: groupId));

      final groupName = chatRoomResponse.netData?.name;
      final groupAvatar = chatRoomResponse.netData?.avatar;
      final groupNumbers = listMemberResponse.total;

      emit(state.copyWith(
        chatRoomId: chatRoomId,
        name: groupName,
        avatar: groupAvatar,
        numberOfMembers: groupNumbers,
      ));

      final firstMessageResponse =
          await _getListMessageChatRoomUseCase.executeList(
              request: GetListRoomMessageParam(
        chatRoomId: chatRoomId,
        order: 'asc',
        limit: 1,
      ));

      emit(state.copyWith(
        createdAt: firstMessageResponse.netData?.first.createdAt,
        userCreate: firstMessageResponse.netData?.first.author,
      ));

      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}

import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

part 'chat_room_info_cubit.freezed.dart';
part 'chat_room_info_state.dart';

@Injectable()
class ChatRoomInfoCubit extends Cubit<ChatRoomInfoState> {
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;

  ChatRoomInfoCubit(this._getChatRoomDetailInfoUseCase)
      : super(const ChatRoomInfoState.initial());

  Future<void> getChatRoomDetail(String roomId) async {
    try {
      final chatRoomResponse = await _getChatRoomDetailInfoUseCase.executeObj(
          request: GetChatRoomInfoParam(id: roomId));
      if (chatRoomResponse.netData != null) {
        emit(state.copyWith(chatRoomInfo: chatRoomResponse.netData));
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}

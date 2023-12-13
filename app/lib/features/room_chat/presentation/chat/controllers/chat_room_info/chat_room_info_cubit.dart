import 'package:app/features/room_chat/domain/usecases/get_chat_room_detail_info_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_info_state.dart';
part 'chat_room_info_cubit.freezed.dart';

class ChatRoomInfoCubit extends Cubit<ChatRoomInfoState> {
  late final GetChatRoomDetailInfoUseCase _getChatRoomDetailInfoUseCase;

  ChatRoomInfoCubit(this._getChatRoomDetailInfoUseCase)
      : super(const ChatRoomInfoState.initial());
}

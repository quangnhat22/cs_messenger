part of 'chat_room_info_cubit.dart';

@freezed
class ChatRoomInfoState with _$ChatRoomInfoState {
  const factory ChatRoomInfoState.initial({
    ChatRoomModel? chatRoomInfo,
    @Default(false) bool isGroupChat,
  }) = _Initial;
}

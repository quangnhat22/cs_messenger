part of 'personal_chat_room_info_cubit.dart';

@freezed
class PersonalChatRoomInfoState with _$PersonalChatRoomInfoState {
  const factory PersonalChatRoomInfoState.initial({
    String? chatRoomId,
    String? friendId,
    String? avatar,
    String? name,
  }) = _Initial;
}

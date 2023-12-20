part of 'call_info_cubit.dart';

enum ConnectVideoCallStatus {
  initial,
  connecting,
  connected,
}

@freezed
class CallInfoState with _$CallInfoState {
  const factory CallInfoState.initial({
    @Default("") String chatRoomId,
    @Default("") String token,
    @Default(ConnectVideoCallStatus.initial) ConnectVideoCallStatus callStatus,
    Room? room,
    EventsListener<RoomEvent>? listener,
  
  }) = _Initial;
}

part of 'list_message_cubit.dart';

@freezed
class ListMessageState with _$ListMessageState {
  const factory ListMessageState.initial({
    UserModel? currentUser,
    @Default([]) List<IMessageModel> listMessage,
    @Default(false) bool isLoading,
    @Default(false) bool isLastPage,
    @Default(false) bool isFirstPage,
    String? nextOffset,
    @Default('-1') String roomId,
    @Default(false) bool isCalling,
  }) = _Initial;
}

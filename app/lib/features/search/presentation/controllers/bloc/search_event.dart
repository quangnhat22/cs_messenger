part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.inputChanged({String? query}) = SearchInputChanged;

  const factory SearchEvent.sendFriendRequest({
    required String userId,
  }) = SearchSendFriendRequest;

  const factory SearchEvent.sendFriendRequestSuccess() =
      SearchSendFriendRequestSuccess;
}

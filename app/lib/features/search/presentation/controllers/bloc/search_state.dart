part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial({
    SearchModel? searchResult,
    @Default(3) int totalResults,
    @Default(false) bool isSentFriendRequestSuccess,
  }) = _Initial;
}

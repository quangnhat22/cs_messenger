part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial({
    SearchModel? searchResult,
  }) = _Initial;
}

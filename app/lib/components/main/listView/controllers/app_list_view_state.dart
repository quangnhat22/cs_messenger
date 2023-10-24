part of 'app_list_view_cubit.dart';

@freezed
class AppListViewState<T extends BaseModel> with _$AppListViewState<T> {
  const factory AppListViewState.initial({
    @Default([]) List<T> data,
    @Default(0) int total,
    AppException? appException,
    @Default(false) bool hasMore,
  }) = _Initial;
}

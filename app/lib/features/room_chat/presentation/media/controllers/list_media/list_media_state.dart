part of 'list_media_cubit.dart';

@freezed
class ListMediaState with _$ListMediaState {
  const factory ListMediaState.initial({
    @Default(false) bool isLoading,
    @Default('') String roomId,
    @Default([]) List<IMessageModel> listPhotos,
    @Default([]) List<IMessageModel> listVideos,
    @Default([]) List<IMessageModel> listFiles,
    @Default([]) List<IMessageModel> listLinks,
  }) = _Initial;
}

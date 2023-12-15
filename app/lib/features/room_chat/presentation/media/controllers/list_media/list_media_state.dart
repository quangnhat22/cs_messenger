part of 'list_media_cubit.dart';

@freezed
class ListMediaState with _$ListMediaState {
  const factory ListMediaState.initial({
    @Default([]) List<IMessageModel> listPhotos,
    @Default([]) List<IMessageModel> listVideos,
    @Default([]) List<IMessageModel> listFiles,
    @Default([]) List<IMessageModel> listLinks,
  }) = _Initial;
}

import 'package:app/features/video_call/data/resources/video_call_remote_data_src.dart';
import 'package:app/features/video_call/domain/repositories/video_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VideoRepository)
class VideoRepositoryImpl extends VideoRepository {
  late final VideoCallRemoteDataSource _remoteDataSource;

  VideoRepositoryImpl(this._remoteDataSource);

  @override
  Future<AppObjResultModel<VideoCallTokenModel>> getVideoCallTokenModel(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<VideoCallTokenRaw> remoteData =
          await _remoteDataSource.getChatRoomVideoCallToken(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppListResultModel<UserModel>> getListMemberVideoCall(
      {required Map<String, dynamic> query}) async {
    try {
      final AppListResultRaw<UserRaw> remoteData =
          await _remoteDataSource.getListMemberVideoCall(query: query);
      return remoteData.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

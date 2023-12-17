import 'package:domain/domain.dart';

abstract class VideoRepository {
  Future<AppObjResultModel<VideoCallTokenModel>> getVideoCallTokenModel(
      {required Map<String, dynamic> query});
}

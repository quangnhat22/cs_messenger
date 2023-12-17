import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class VideoCallRemoteDataSource {
  Future<AppObjResultRaw<VideoCallTokenRaw>> getChatRoomVideoCallToken(
      {required Map<String, dynamic> query});
}

@Injectable(as: VideoCallRemoteDataSource)
class VideoCallRemoteDataSourceImpl extends VideoCallRemoteDataSource {
  late final NetworkService _service;

  VideoCallRemoteDataSourceImpl(this._service);

  @override
  Future<AppObjResultRaw<VideoCallTokenRaw>> getChatRoomVideoCallToken(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.chatRoomVideoCallById(query['chatRoomId']),
          method: HttpMethod.get,
        ),
      );
      return response.toRaw((data) => VideoCallTokenRaw.fromJson(data));
    } on AppException catch (_) {
      rethrow;
    }
  }
}

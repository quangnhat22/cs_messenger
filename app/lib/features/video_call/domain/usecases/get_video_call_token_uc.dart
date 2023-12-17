import 'package:app/features/video_call/domain/repositories/video_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetVideoCallTokenUseCase
    extends BaseUseCase<GetVideoCallTokenParam, VideoCallTokenModel> {}

@Injectable(as: GetVideoCallTokenUseCase)
class GetVideoCallTokenUseCaseImpl extends GetVideoCallTokenUseCase {
  late final VideoRepository _repo;

  GetVideoCallTokenUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<VideoCallTokenModel>> executeObj(
          {GetVideoCallTokenParam? request}) async =>
      await _repo.getVideoCallTokenModel(query: request?.toJson() ?? {});
}

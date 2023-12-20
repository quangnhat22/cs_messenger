import 'package:app/features/video_call/domain/repositories/video_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListMemberVideoCallUseCase
    extends BaseUseCase<GetVideoCallTokenParam, UserModel> {}

@Injectable(as: GetListMemberVideoCallUseCase)
class GetVideoCallTokenUseCaseImpl extends GetListMemberVideoCallUseCase {
  late final VideoRepository _repo;

  GetVideoCallTokenUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<UserModel>> executeList(
          {GetVideoCallTokenParam? request}) async =>
      await _repo.getListMemberVideoCall(query: request?.toJson() ?? {});
}

import 'package:app/features/friend/domain/repositories/friend_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteFriendUseCase
    extends BaseUseCase<ActionRequestParam, EmptyModel> {}

@Injectable(as: DeleteFriendUseCase)
class DeleteFriendUseCaseImpl extends DeleteFriendUseCase {
  final FriendRepository _repo;

  DeleteFriendUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.deleteFriendRequest(query: request?.toJson() ?? {});
}

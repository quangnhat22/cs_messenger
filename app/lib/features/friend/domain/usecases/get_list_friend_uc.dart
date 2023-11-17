import 'package:app/features/friend/domain/repositories/friend_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListFriendUseCase
    extends BaseUseCase<GetListFriendParam, UserModel> {}

@Injectable(as: GetListFriendUseCase)
class GetListFriendUseCaseImpl extends GetListFriendUseCase {
  final FriendRepository _repo;

  GetListFriendUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<UserModel>> executeList(
          {GetListFriendParam? request}) =>
      _repo.getListFriend(query: request?.toJson() ?? {});
}

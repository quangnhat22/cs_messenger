import 'package:app/features/friend/domain/repositories/friend_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListFriendRequestUseCase
    extends BaseUseCase<GetListFriendRequestParam, RequestModel> {}

@Injectable(as: GetListFriendRequestUseCase)
class GetListCallHistoryUseCaseImpl extends GetListFriendRequestUseCase {
  final FriendRepository _repo;

  GetListCallHistoryUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<RequestModel>> executeList(
          {GetListFriendRequestParam? request}) =>
      _repo.getListFriendRequest(query: request?.toJson() ?? {});
}

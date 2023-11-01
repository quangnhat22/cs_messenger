import 'package:app/features/friend/domain/repositories/friend_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListCallHistoryUseCase
    extends BaseUseCase<GetListCallHistoryParam, HistoryCallModel> {}

@Injectable(as: GetListCallHistoryUseCase)
class GetListCallHistoryUseCaseImpl extends GetListCallHistoryUseCase {
  final FriendRepository _repo;

  GetListCallHistoryUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<HistoryCallModel>> executeList(
          {GetListCallHistoryParam? request}) async =>
      await _repo.getListCallHistory(query: request?.toJson() ?? {});
}

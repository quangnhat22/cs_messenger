import 'package:app/features/user/domain/repositories/block_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListBlockUseCase
    extends BaseUseCase<GetListFriendParam, UserModel> {}

@Injectable(as: GetListBlockUseCase)
class GetListBlockUseCaseImpl extends GetListBlockUseCase {
  final BlockRepository _repo;

  GetListBlockUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<UserModel>> executeList(
          {GetListFriendParam? request}) async =>
      await _repo.getListUserBlock(query: request?.toJson() ?? {});
}

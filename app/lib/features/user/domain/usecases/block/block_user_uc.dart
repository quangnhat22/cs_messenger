import 'package:app/features/user/domain/repositories/block_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class BlockUserUseCase
    extends BaseUseCase<ActionRequestParam, EmptyModel> {}

@Injectable(as: BlockUserUseCase)
class BlockUserUseCaseImpl extends BlockUserUseCase {
  final BlockRepository _repo;

  BlockUserUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.blockUser(query: request?.toJson() ?? {});
}

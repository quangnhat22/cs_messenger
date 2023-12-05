import 'package:app/features/user/domain/repositories/block_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UnBlockUserUseCase
    extends BaseUseCase<ActionRequestParam, EmptyModel> {}

@Injectable(as: UnBlockUserUseCase)
class BlockUserUseCaseImpl extends UnBlockUserUseCase {
  final BlockRepository _repo;

  BlockUserUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ActionRequestParam? request}) async =>
      await _repo.unBlockUser(query: request?.toJson() ?? {});
}

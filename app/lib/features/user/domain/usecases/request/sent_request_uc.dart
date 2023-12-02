import 'package:app/features/user/domain/repositories/request_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SentRequestUseCase
    extends BaseUseCase<SentRequestParam, EmptyModel> {}

@Injectable(as: SentRequestUseCase)
class SentRequestUseCaseImpl extends SentRequestUseCase {
  final RequestRepository _repo;

  SentRequestUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {SentRequestParam? request}) async =>
      await _repo.sentRequest(query: request?.toJson() ?? {});
}

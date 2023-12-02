import 'package:app/features/search/domain/repositories/search_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SearchUseCase extends BaseUseCase<SearchParam, SearchModel> {}

@Injectable(as: SearchUseCase)
class SearchUseCaseImpl extends SearchUseCase {
  final SearchRepository _repo;

  SearchUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<SearchModel>> executeObj(
          {SearchParam? request}) async =>
      await _repo.search(query: request?.toJson() ?? {});
}

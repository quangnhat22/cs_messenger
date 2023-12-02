import 'package:app/features/search/data/sources/search_remote_data_src.dart';
import 'package:app/features/search/domain/repositories/search_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  late final SearchRemoteDataSource _remote;

  SearchRepositoryImpl(this._remote);

  @override
  Future<AppObjResultModel<SearchModel>> search(
      {required Map<String, dynamic> query}) async {
    try {
      final AppObjResultRaw<SearchRaw> remoteData =
          await _remote.search(query: query);
      return remoteData.raw2Model();
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

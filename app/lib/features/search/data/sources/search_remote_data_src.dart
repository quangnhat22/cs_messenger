import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SearchRemoteDataSource {
  Future<AppObjResultRaw<SearchRaw>> search(
      {required Map<String, dynamic> query});
}

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  late final NetworkService _service;

  SearchRemoteDataSourceImpl(this._service);

  @override
  Future<AppObjResultRaw<SearchRaw>> search(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.search,
          method: HttpMethod.get,
          query: query,
        ),
      );
      return response.toRaw((data) => SearchRaw.fromJson(data));
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

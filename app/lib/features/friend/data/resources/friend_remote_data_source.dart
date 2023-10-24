import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class FriendRemoteDataSource {
  Future<AppListResultRaw<HistoryCallRaw>> fetchListCallHistory(
      {required Map<String, dynamic> query});
}

@Injectable(as: FriendRemoteDataSource)
class FriendRemoteDataSourceImpl extends FriendRemoteDataSource {
  late final NetworkService _service;

  FriendRemoteDataSourceImpl(this._service);

  @override
  Future<AppListResultRaw<HistoryCallRaw>> fetchListCallHistory(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.callHistory,
          method: HttpMethod.get,
          query: query,
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => HistoryCallRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

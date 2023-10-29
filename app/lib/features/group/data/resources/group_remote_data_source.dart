import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GroupRemoteDataSource {
  Future<AppListResultRaw<GroupRaw>> fetchListGroup(
      {required Map<String, dynamic> query});
}

@Injectable(as: GroupRemoteDataSource)
class FriendRemoteDataSourceImpl extends GroupRemoteDataSource {
  late final NetworkService _service;

  FriendRemoteDataSourceImpl(this._service);

  @override
  Future<AppListResultRaw<GroupRaw>> fetchListGroup(
      {required Map<String, dynamic> query}) async {
    try {
      final AppResponse response = await _service.request(
        clientRequest: ClientRequest(
          url: ApiProvider.groupList,
          method: HttpMethod.get,
          query: query,
          isRequestForList: true,
        ),
      );
      return response.toRawList((data) => (data as List<dynamic>)
          .map((item) => GroupRaw.fromJson(item))
          .toList());
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}

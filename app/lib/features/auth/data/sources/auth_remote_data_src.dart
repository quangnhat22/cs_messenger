import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AppObjResultRaw<TokenRaw>> registerNewAccount(
      {required Map<String, dynamic> body});

  Future<AppObjResultRaw<TokenRaw>> loginWithGoogle(
      {required Map<String, dynamic> body});
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<AppObjResultRaw<TokenRaw>> registerNewAccount(
      {required Map<String, dynamic> body}) {
    // try {
    //   final AppResponse response = await _service.request(
    //     clientRequest: ClientRequest(
    //       url: ApiProvider.friendCallHistory,
    //       method: HttpMethod.get,
    //       query: query,
    //       isRequestForList: true,
    //     ),
    //   );
    //   return response.toRawList((data) => (data as List<dynamic>)
    //       .map((item) => HistoryCallRaw.fromJson(item))
    //       .toList());
    // } on NetworkException catch (_) {
    //   rethr
    throw UnimplementedError();
  }

  @override
  Future<AppObjResultRaw<TokenRaw>> loginWithGoogle(
      {required Map<String, dynamic> body}) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}

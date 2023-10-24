part of 'network_service.dart';

class NetworkInterceptorWrapper extends QueuedInterceptorsWrapper {
  late final Dio diO;

  NetworkInterceptorWrapper({required this.diO});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll(_headerToken());

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Go Next when call api login || refreshToken
    // if (err.requestOptions.path.contains(ApiProvider.loginWithOtable) ||
    //     err.requestOptions.path.contains(ApiProvider.refreshToken)) {
    //   return handler.next(err);
    // }
    // Do something with response error
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final isHasToken = await _refreshToken();
      if (!isHasToken) {
        return handler.next(err);
      }
      //err.requestOptions.headers.remove(AppNetworkKey.authorization);
      err.requestOptions.headers.addAll(_headerToken());

      final opts = Options(
        headers: err.requestOptions.headers,
        method: err.requestOptions.method,
      );

      final cloneReq = await diO.request(
        err.requestOptions.path,
        options: opts,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        onSendProgress: err.requestOptions.onSendProgress,
        onReceiveProgress: err.requestOptions.onReceiveProgress,
        cancelToken: err.requestOptions.cancelToken,
      );
      if (cloneReq.isOk) {
        return handler.resolve(cloneReq);
      }
      return handler
          .reject(DioException(requestOptions: err.response!.requestOptions));
    }

    return handler.next(err);
  }

  //TODO:handle this
  Map<String, String> _headerToken() {
    // final token = _pref.getString(AppPrefKey.token, '');
    // return {AppNetworkKey.authorization: '${AppNetworkKey.bearer} $token'};
    return {"token": "null"};
  }

  //TODO: handle this
  Future<bool> _refreshToken() async {
    // final newDio = NetworkService.newDio();
    // try {
    //   final refreshToken = _pref.getString(AppPrefKey.refreshToken, '');
    //   final headerToken = _headerToken();
    //   final response = await newDio.get(
    //     ApiProvider.refreshToken,
    //     queryParameters: {AppPrefKey.refreshToken: refreshToken},
    //     options: Options(headers: headerToken),
    //   );
    //   final AppResponse appResponse = AppResponse.fromJson(response.data);
    //
    //   if (HttpStatus(response.statusCode).isOk) {
    //     final tokenVo = TokenRaw.fromJson(appResponse.data);
    //     await _pref.setString(AppPrefKey.token, tokenVo.accessToken);
    //     await _pref.setString(AppPrefKey.refreshToken, tokenVo.refreshToken);
    //   }
    //   newDio.close(force: true);
    //
    //   return HttpStatus(response.statusCode).isOk;
    // } catch (_) {
    //   newDio.close(force: true);
    //
    //   return false;
    return false;
  }
}

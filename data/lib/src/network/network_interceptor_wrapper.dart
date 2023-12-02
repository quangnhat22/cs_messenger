part of 'network_service.dart';

class NetworkInterceptorWrapper extends QueuedInterceptorsWrapper {
  late final Dio diO;

  late final AppSharedPref pref;

  NetworkInterceptorWrapper({required this.diO, required this.pref});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll(_headerToken());

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Go Next when call api login || refreshToken
    if (err.requestOptions.path.contains(ApiProvider.loginByEmailAndPassword) ||
        err.requestOptions.path.contains(ApiProvider.signUpWithEmail) ||
        err.requestOptions.path.contains(ApiProvider.deviceRegister)) {
      return handler.next(err);
    }
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
    final token = pref.getString(AppPrefKey.token, '');
    return {AppNetworkKey.authorization: '${AppNetworkKey.bearer} $token'};
  }

  Future<bool> _refreshToken() async {
    final newDio = NetworkService.newDio();
    try {
      final refreshToken = pref.getString(AppPrefKey.refreshToken, '');
      final response = await newDio.post(ApiProvider.getNewAccessToken, data: {
        "refresh_token": refreshToken,
      });
      final AppResponse appResponse = AppResponse.fromJson(response.data);

      if (response.isOk) {
        final newToken = TokenRaw.fromJson(appResponse.data);
        await pref.setString(AppPrefKey.token, newToken.accessToken!);
        //TODO: handle this
        await pref.setString(AppPrefKey.refreshToken, refreshToken);
      }
      newDio.close(force: true);

      return response.isOk;
    } catch (_) {
      newDio.close(force: true);

      return false;
    }
  }
}

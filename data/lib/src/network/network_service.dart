import 'dart:io';

import 'package:configs/configs.dart';
import 'package:data/src/raw/base_raw.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'api_provider.dart';
part 'client_request.dart';
part 'network_interceptor_wrapper.dart';

abstract class NetworkService {
  static Dio newDio() {
    final dio = Dio(BaseOptions(
      baseUrl: BuildConfig.apiDomain,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }

  Future<AppResponse> request({required ClientRequest clientRequest});
}

@Singleton(as: NetworkService)
class NetworkServiceImpl extends NetworkService {
  late final Dio _dio;

  NetworkServiceImpl() {
    _dio = NetworkService.newDio();
    _dio.interceptors.add(NetworkInterceptorWrapper(diO: _dio));
  }

  @override
  Future<AppResponse> request({required ClientRequest clientRequest}) async {
    try {
      final response = await _dio.request(
        clientRequest.url,
        data: clientRequest.body,
        options: Options(
          method: clientRequest.method.value,
          contentType: clientRequest.contentType,
          headers: {...clientRequest.headers ?? {}},
        ),
        queryParameters: clientRequest.query,
        onSendProgress: clientRequest.onSendProgress,
        onReceiveProgress: clientRequest.onReceiveProgress,
      );
      final AppResponse appResponse = clientRequest.isRequestForList
          ? AppResponse.fromJsonToList(response.data)
          : AppResponse.fromJson(response.data);
      return response.isOk
          ? appResponse
          : throw NetworkException(
              code: response.statusCode,
              message: appResponse.meta?.message,
              errorCode: appResponse.meta?.code,
            );
    } on DioException catch (e) {
      Metadata? meta = (e.response?.data is Map<String, dynamic>)
          ? Metadata(
              code: e.response?.data['code'].toString(),
              message: e.response?.data['message'],
            )
          : Metadata(
              code: ErrorCode.dioError,
              message: null,
            );

      throw NetworkException(
        code: e.response?.statusCode,
        message: meta.message,
        errorCode: ErrorCode.dioError,
      );
    } catch (e) {
      throw NetworkException(
        code: Code.code999,
        message: 'SomeThingsWrong: ${e.toString()}',
        errorCode: ErrorCode.networkServiceError,
      );
    }
  }
}

extension IsOk on Response {
  bool get isOk {
    return (statusCode! ~/ 100) == 2;
  }
}

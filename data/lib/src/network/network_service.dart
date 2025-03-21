import 'dart:io';

import 'package:configs/configs.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:utilities/utilities.dart';

part 'api_provider.dart';
part 'client_request.dart';
part 'network_interceptor_wrapper.dart';

abstract class NetworkService {
  static Dio newDio() {
    final dio = Dio(BaseOptions(
      baseUrl: BuildConfig.apiDomain,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
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
  late final AppSharedPref _pref;

  NetworkServiceImpl(this._pref) {
    _dio = NetworkService.newDio();
    _dio.interceptors.add(NetworkInterceptorWrapper(diO: _dio, pref: _pref));
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

      if (appResponse.meta?.code != null && appResponse.meta!.code != '0') {
        throw GrpcException(
          code: appResponse.meta?.statusCode,
          message: appResponse.meta?.message,
          errorCode: appResponse.meta?.code,
          data: appResponse.data,
        );
      }

      return response.isOk
          ? appResponse
          : throw NetworkException(
              code: response.statusCode,
              message: appResponse.meta?.message,
              errorCode: appResponse.meta?.code,
            );
    } on DioException catch (e) {
      if (e.response?.data["metadata"]["code"] != null &&
          e.response?.data["metadata"]["code"] != 0) {
        throw GrpcException(
          code: e.response?.data["metadata"]["statusCode"],
          message: e.response?.data["metadata"]["message"],
          errorCode: e.response?.data["metadata"]["code"].toString(),
        );
      }

      Metadata? meta = (e.response?.data is Map<String, dynamic>)
          ? Metadata(
              code: e.response?.data['metadata']['code'].toString(),
              message: e.response?.data['metadata']['message'],
            )
          : Metadata(
              code: ErrorCode.dioError,
              message: e.message,
            );

      if (e.response?.statusCode != null) {
        throw NetworkException(
          code: e.response!.statusCode!,
          message: meta.message,
          errorCode: ErrorCode.dioError,
        );
      } else {
        throw NetworkException(
          code: Code.code999,
          message: 'SomeThingsWrong: ${e.message.toString()}',
          errorCode: ErrorCode.networkServiceError,
        );
      }
    } catch (e) {
      if (e is GrpcException) {
        throw GrpcException(
          code: e.code,
          message: e.message,
          errorCode: e.errorCode,
          data: e.data,
        );
      }
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

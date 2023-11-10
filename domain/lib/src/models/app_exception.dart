part of 'base_model.dart';

abstract class AppException implements Exception {
  final int? code; // HTTP Status
  final String? errorCode;
  final String? message;

  AppException({this.code, this.message, this.errorCode});

  @override
  String toString() {
    return "[$code]: $message : $errorCode";
  }
}

class NetworkException extends AppException {
  NetworkException({super.code, super.message, super.errorCode});
}

class GrpcException extends AppException {
  final Map<String, dynamic>? data;

  GrpcException({super.code, super.message, super.errorCode, this.data});
}

class LocalException extends AppException {
  LocalException({super.code, super.message, super.errorCode});
}

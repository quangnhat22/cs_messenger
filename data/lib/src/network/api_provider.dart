part of 'network_service.dart';

class ApiProvider {
  static const String mockServerUrl =
      'https://166706c7-b0dd-4262-a9a8-9e7b5f3dd1be.mock.pstmn.io';

  //device
  static const String _deviceUrl = '/device';
  static const String deviceRegister = '$_deviceUrl/register';

  //auth
  //TODO: mockApi
  static const String friendCallHistory = "$mockServerUrl/friend/call-history";
  static const String friendRequest = "$mockServerUrl/friend/friend-request";
  static const String groupList = "$mockServerUrl/group/group-list";
}

class ApiExternal {}

class Code extends HttpStatus {
  static const int code999 = 999;
}

class ErrorCode {
  ErrorCode._();

  static const String hiveError = 'hive_error';
  static const String dioError = 'dio_error';
  static const String networkServiceError = 'network_service_error';
}

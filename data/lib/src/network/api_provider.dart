part of 'network_service.dart';

class ApiProvider {
  //auth
  static const String _auth = '/auth';
  static const String getNewAccessToken = '$_auth/access-token';
  static const String signUpWithEmail = '$_auth/email/signup';
  static const String loginFirebase = '$_auth/firebase/login';
  static const String loginByEmailAndPassword = '$_auth/email/login';
  static const String verifyEmail = '$_auth/email-verifying-status';
  static const String forgetPassword = '$_auth/email/forget-password';
  static const String requestResendEmail = '$_auth/send-verify-email';
  static const String logOut = '$_auth/logout';
  static const String changePassword = '$_auth/update-password';

  //device
  static const String _deviceUrl = '/device';
  static const String deviceRegister = '$_deviceUrl/register';

  //user-self
  static const String userSelfUrl = '/self';

  //user
  static const String user = '/user';

  static String userById(String id) => '$user/$id';

  //block user
  static const String blockUser = '/block/user';

  static String blockUserById(String id) => '$blockUser/$id';

  //search
  static const String search = '/search';

  //request
  static const String request = '/request';

  static String requestById(String id) => '$request/$id';

  //friend
  static const String friend = '/friend';

  static String friendById(String id) => '$friend/$id';

  //group
  static const String group = '/group';

  static String groupById(String id) => '$group/$id';

  //group
  static const String chatRoom = '/chatroom';

  static String chatRoomById(String id) => '$chatRoom/$id';
  static String chatRoomMessageById(String id) => '$chatRoom/$id/message';

  //TODO: mockApi
  static const String mockServerUrl =
      'https://166706c7-b0dd-4262-a9a8-9e7b5f3dd1be.mock.pstmn.io';
  static const String friendCallHistory = "$mockServerUrl/friend/call-history";
  static const String friendRequest = "$mockServerUrl/friend/friend-request";
  static const String friendList = "$mockServerUrl/friend/list";
  static const String groupList = "$mockServerUrl/group/group-list";
  static const String mockBlockUser = '$mockServerUrl/block/list';
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

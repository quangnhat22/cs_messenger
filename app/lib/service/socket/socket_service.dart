import 'package:app/features/auth/data/sources/local/auth_local_data_src.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:utilities/utilities.dart';

@Singleton()
class SocketService {
  IO.Socket? _socket;
  late final AuthLocalDataSource _authLocalDataSource;

  SocketService(this._authLocalDataSource);

  void connectSocket() async {
    final token = await _authLocalDataSource.getToken();
    _socket = IO.io(
        'http://103.153.73.170:30002',
        IO.OptionBuilder().setTransports(['websocket'])
            //.enableForceNew()
            //.disableAutoConnect() // for Flutter or Dart VM
            .setExtraHeaders({
          'Authorization': 'Bearer ${token.netData?.accessToken}',
        }).build());
    _socket?.onConnecting((data) => Logs.d("connecting"));
    _socket?.onConnect((data) => Logs.d("connected"));
    _socket?.onDisconnect((data) => Logs.d("disconnected"));
    _socket?.on('register', (data) => Logs.d(data));
    // _socket.on('new-message', ((data) => socketNewMessage(data)));
    // _socket.on('new-notification', ((data) => socketNewNotification(data)));
    // _socket.on('webrtc', ((data) => socketNewCallWebRTC(data)));
    // _socket.on('email-verified', ((data) => socketNewEmailVerified(data)));
    // _socket.on('friend-deleted', ((_) => socketNewEventChatRoom()));
    // _socket.on('chatroom-deleted', ((_) => socketNewEventChatRoom()));
    // _socket.on('room-left', ((_) => socketNewEventChatRoom()));
  }

  void socketDisconnected() {
    if (_socket != null) {
      if (_socket!.connected) {
        _socket!.disconnect();
      }

      // // dispose controller
      // dispose();
    }
  }
}

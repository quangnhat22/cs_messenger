import 'dart:async';

import 'package:app/features/auth/data/sources/local/auth_local_data_src.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:utilities/utilities.dart';

abstract class RealtimeService {
  void connectSocket();

  void disconnectSocket();

  void sendMessages(Map<String, dynamic> message);

  Stream<AppObjResultRaw<MessageRaw>> receiveNewMessageStream(dynamic data);
}

@Singleton(as: RealtimeService)
class SocketService implements RealtimeService {
  late final IO.Socket _socket;
  late final AuthLocalDataSource _authLocalDataSource;

  SocketService(this._authLocalDataSource);

  static const String _newMessageEvent = 'new-message';

  StreamController<AppObjResultRaw<MessageRaw>> newMessageController =
      StreamController<AppObjResultRaw<MessageRaw>>.broadcast();

  @override
  void connectSocket() async {
    final token = await _authLocalDataSource.getToken();
    _socket = IO.io(
        'http://103.153.73.170:30002',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            //.enableForceNew()
            //.disableAutoConnect() // for Flutter or Dart VM
            .setExtraHeaders({
              'Authorization': 'Bearer ${token.netData?.accessToken}',
            })
            .enableForceNew()
            .build());
    _socket.onConnecting((data) => Logs.d("connecting"));
    _socket.onConnect((data) => Logs.d("connected"));
    _socket.onDisconnect((data) => Logs.d("disconnected"));
    _socket.on('register', (data) => Logs.d(data));
    _socket.on(_newMessageEvent, ((data) => receiveNewMessageStream(data)));
    // _socket.on('new-notification', ((data) => socketNewNotification(data)));
    // _socket.on('webrtc', ((data) => socketNewCallWebRTC(data)));
    // _socket.on('email-verified', ((data) => socketNewEmailVerified(data)));
    // _socket.on('friend-deleted', ((_) => socketNewEventChatRoom()));
    // _socket.on('chatroom-deleted', ((_) => socketNewEventChatRoom()));
    // _socket.on('room-left', ((_) => socketNewEventChatRoom()));
  }

  @override
  void disconnectSocket() {
    _socket.disconnect();
    _dispose();
  }

  void _dispose() {
    newMessageController.close();
  }

  @override
  void sendMessages(Map<String, dynamic> message) {
    _socket.emit(_newMessageEvent, message);
  }

  @override
  Stream<AppObjResultRaw<MessageRaw>> receiveNewMessageStream(dynamic data) {
    Logs.d(data);
    final resonse = AppResponse.fromJson(data as Map<String, dynamic>);

    final rawData = <String, Object?>{
      ...resonse.data,
      "author": {
        'id': '2',
        'name': 'Nguyen Van A',
        'avatar': 'https://i.pravatar.cc/150?img=3',
      },
    };

    final newMessage = MessageRaw.fromJson(rawData);
    // _newMessageController.sink.add(newMessage);
    return newMessageController.stream;
  }
}

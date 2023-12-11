import 'package:app/features/room_chat/domain/repositories/message_repository.dart';
import 'package:app/service/socket/socket_service.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

@Injectable(as: MessageRepository)
class MessageRepositoryImpl extends MessageRepository {
  late final RealtimeService _realtimeService;

  MessageRepositoryImpl(this._realtimeService);

  @override
  Future<AppObjResultModel<EmptyModel>> sendMessage(
      {required Map<String, dynamic> message}) async {
    try {
      _realtimeService.sendMessages(message);
      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      Logs.e(e);
      rethrow;
    }
  }

  @override
  Stream<AppObjResultModel<IMessageModel>> getNewMessageStream() {
    return _realtimeService.getReceiveNewMessageStream().map((messageRaw) {
      return messageRaw.raw2Model();
    });
  }
}

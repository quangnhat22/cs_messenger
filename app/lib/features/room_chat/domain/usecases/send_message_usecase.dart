import 'package:app/features/room_chat/domain/repositories/message_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SendMessageUseCase
    extends BaseUseCase<SocketMessageParam, EmptyModel> {}

@Injectable(as: SendMessageUseCase)
class SendMessageUseCaseImpl extends SendMessageUseCase {
  final MessageRepository _repo;

  SendMessageUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {SocketMessageParam? request}) async =>
      await _repo.sendMessage(message: request?.toJson() ?? {});
}

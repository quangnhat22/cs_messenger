import 'package:app/features/room_chat/domain/repositories/chat_room_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListMessageChatRoomUseCase
    extends BaseUseCase<GetListRoomMessageParam, IMessageModel> {}

@Injectable(as: GetListMessageChatRoomUseCase)
class GetListMessageChatRoomUseCaseImpl extends GetListMessageChatRoomUseCase {
  final ChatRoomRepository _repo;

  GetListMessageChatRoomUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<IMessageModel>> executeList(
          {GetListRoomMessageParam? request}) async =>
      await _repo.getListMessage(query: request?.toJson() ?? {});
}

import 'package:app/features/room_chat/domain/repositories/chat_room_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetListChatRoomUseCase
    extends BaseUseCase<GetListChatRoomParam, ChatRoomModel> {}

@Injectable(as: GetListChatRoomUseCase)
class GetListChatRoomUseCaseImpl extends GetListChatRoomUseCase {
  final ChatRoomRepository _repo;

  GetListChatRoomUseCaseImpl(this._repo);

  @override
  Future<AppListResultModel<ChatRoomModel>> executeList(
          {GetListChatRoomParam? request}) async =>
      await _repo.getListChatRoom(query: request?.toJson() ?? {});
}

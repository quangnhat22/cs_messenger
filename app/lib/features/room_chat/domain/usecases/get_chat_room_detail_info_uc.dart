import 'package:app/features/room_chat/domain/repositories/chat_room_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetChatRoomDetailInfoUseCase
    extends BaseUseCase<GetChatRoomInfoParam, ChatRoomModel> {}

@Injectable(as: GetChatRoomDetailInfoUseCase)
class GetChatRoomDetailInfoUseCaseImpl extends GetChatRoomDetailInfoUseCase {
  final ChatRoomRepository _repo;

  GetChatRoomDetailInfoUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<ChatRoomModel>> executeObj(
          {GetChatRoomInfoParam? request}) async =>
      await _repo.getChatRoomInfo(query: request?.toJson() ?? {});
}

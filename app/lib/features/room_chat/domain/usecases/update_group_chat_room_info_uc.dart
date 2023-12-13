import 'package:app/features/room_chat/domain/repositories/chat_room_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateGroupChatRoomInfoUseCase
    extends BaseUseCase<BaseParam, EmptyModel> {}

@Injectable(as: UpdateGroupChatRoomInfoUseCase)
class UpdateGroupChatRoomInfoUseCaseImpl
    extends UpdateGroupChatRoomInfoUseCase {
  final ChatRoomRepository _repo;

  UpdateGroupChatRoomInfoUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.updateChatRoomInfo(query: {});
}

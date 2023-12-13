import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_chat_room_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListChatRoomCubit extends AppListViewCubit<ChatRoomModel> {
  late final GetListChatRoomUseCase _getListFriendUseCase;

  ListChatRoomCubit(this._getListFriendUseCase);

  @override
  Future<AppListResultModel<ChatRoomModel>> onCall(AppParam appParam) async {
    return _getListFriendUseCase.executeList(
      request: GetListChatRoomParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

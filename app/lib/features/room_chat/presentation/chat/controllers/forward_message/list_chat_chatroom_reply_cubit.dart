import 'dart:async';

import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/room_chat/domain/usecases/get_list_chat_room_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListChatRoomReplyCubit extends AppListViewCubit<ChatRoomModel> {
  late final GetListChatRoomUseCase _getListChatRoomUseCase;

  ListChatRoomReplyCubit(this._getListChatRoomUseCase);

  @override
  Future<AppListResultModel<ChatRoomModel>> onCall(AppParam appParam) async {
    return _getListChatRoomUseCase.executeList(
      request: GetListChatRoomParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

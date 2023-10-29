import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_enum_exts.dart';
import 'package:app/features/friend/domain/features/get_list_friend_request/get_list_friend_request_param.dart';
import 'package:app/features/friend/domain/features/get_list_friend_request/get_list_friend_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListFriendSentRequestCubit extends AppListViewCubit<RequestModel> {
  final GetListFriendRequestUseCase _useCase;

  ListFriendSentRequestCubit(this._useCase);

  @override
  Future<AppListResultModel<RequestModel>> onCall(AppParam appParam) async {
    return _useCase.executeList(
      request: GetListFriendRequestParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
        type: AppRequestType.friendReceived.type,
        direction: AppRequestType.friendReceived.direction,
      ),
    );
  }
}

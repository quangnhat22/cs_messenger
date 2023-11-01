import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_enum_exts.dart';
import 'package:app/features/friend/domain/usecases/get_list_friend_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListFriendReceivedRequestCubit extends AppListViewCubit<RequestModel> {
  final GetListFriendRequestUseCase _useCase;

  ListFriendReceivedRequestCubit(this._useCase);

  @override
  Future<AppListResultModel<RequestModel>> onCall(AppParam appParam) {
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

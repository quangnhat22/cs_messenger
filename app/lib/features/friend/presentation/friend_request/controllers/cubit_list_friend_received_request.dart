import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_enum_exts.dart';
import 'package:app/features/user/domain/usecases/request/get_list_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListFriendReceivedRequestCubit extends AppListViewCubit<RequestModel> {
  final GetListRequestUseCase _useCase;

  ListFriendReceivedRequestCubit(this._useCase);

  @override
  Future<AppListResultModel<RequestModel>> onCall(AppParam appParam) {
    return _useCase.executeList(
      request: GetListRequestParam(
        page: appParam.page,
        limit: appParam.pageSize,
        type: AppRequestType.friendReceived.type,
        direction: AppRequestType.friendReceived.direction,
      ),
    );
  }
}

import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_enum_exts.dart';
import 'package:app/features/user/domain/usecases/request/get_list_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListGroupSentRequestCubit extends AppListViewCubit<RequestModel> {
  final GetListRequestUseCase _useCase;

  ListGroupSentRequestCubit(this._useCase);

  @override
  Future<AppListResultModel<RequestModel>> onCall(AppParam appParam) async {
    return _useCase.executeList(
      request: GetListRequestParam(
        page: appParam.page,
        limit: appParam.pageSize,
        type: AppRequestType.groupSent.type,
        direction: AppRequestType.groupSent.direction,
      ),
    );
  }
}

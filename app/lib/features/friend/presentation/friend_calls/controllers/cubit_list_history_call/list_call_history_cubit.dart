import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/friend/domain/usecases/get_list_call_history_call_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListCallHistoryCubit extends AppListViewCubit<HistoryCallModel> {
  GetListCallHistoryUseCase useCase;

  ListCallHistoryCubit(this.useCase);

  @override
  Future<AppListResultModel<HistoryCallModel>> onCall(AppParam appParam) async {
    return useCase.executeList(
      request: GetListCallHistoryParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

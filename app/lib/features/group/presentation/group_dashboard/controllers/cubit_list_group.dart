import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/group/domain/features/get_list_group/get_list_group_param.dart';
import 'package:app/features/group/domain/features/get_list_group/get_list_group_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ListGroupCubit extends AppListViewCubit<GroupModel> {
  final GetListGroupUseCase _useCase;

  ListGroupCubit(this._useCase);

  @override
  Future<AppListResultModel<GroupModel>> onCall(AppParam appParam) {
    return _useCase.executeList(
      request: GetListGroupParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

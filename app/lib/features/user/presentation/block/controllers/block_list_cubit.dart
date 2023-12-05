import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/user/domain/usecases/block/get_list_block_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetListBlockCubit extends AppListViewCubit<UserModel> {
  late final GetListBlockUseCase _getListBlockUseCase;

  GetListBlockCubit(this._getListBlockUseCase);

  @override
  Future<AppListResultModel<UserModel>> onCall(AppParam appParam) async {
    return _getListBlockUseCase.executeList(
      request: GetListFriendParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

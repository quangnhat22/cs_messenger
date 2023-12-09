import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/features/friend/domain/usecases/get_list_friend_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class InviteListFriendCubit extends AppListViewCubit<UserModel> {
  late final GetListFriendUseCase _getListFriendUseCase;

  InviteListFriendCubit(this._getListFriendUseCase);

  @override
  Future<AppListResultModel<UserModel>> onCall(AppParam appParam) async {
    return _getListFriendUseCase.executeList(
      request: GetListFriendParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }
}

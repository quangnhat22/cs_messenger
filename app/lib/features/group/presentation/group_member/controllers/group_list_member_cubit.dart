import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/group/domain/usecases/get_list_member_group_uc.dart';
import 'package:app/features/user/domain/usecases/request/sent_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class GroupListMemberCubit extends AppListViewCubit<UserModel> {
  late final GetListMemberGroupUseCase _getListMemberGroupUseCase;
  late final SentRequestUseCase _sentRequestUseCase;

  GroupListMemberCubit(
    this._getListMemberGroupUseCase,
    this._sentRequestUseCase,
  );

  String? _groupId;

  Future<void> initPage(groupId) async {
    try {
      _groupId = groupId;
      await onRefreshCall();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  @override
  Future<AppListResultModel<UserModel>> onCall(AppParam appParam) async {
    if (_groupId == null) {
      return AppListResultModel(netData: List.empty());
    } else {
      return _getListMemberGroupUseCase.executeList(
        request: GetListMemberGroupParam(
          groupId: _groupId!,
          page: appParam.page,
          pageSize: appParam.pageSize,
        ),
      );
    }
  }

  Future<void> inviteMember(List<UserModel> friends) async {
    try {
      if (friends.isEmpty) return;
      bool isSuccess = true;

      friends.forEach((friend) async {
        try {
          await _sentRequestUseCase.executeObj(
              request: SentRequestParam(
            userId: friend.id,
            groupId: _groupId,
          ));
        } catch (_) {
          AppDefaultDialogWidget()
              .setTitle(R.strings.error)
              .setContent(R.strings.sendGroupRequestFail(friend.name ?? '-'))
              .setAppDialogType(AppDialogType.error)
              .setNegativeText(R.strings.close)
              .setPositiveText(R.strings.confirm)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
          isSuccess = false;
        }
      });
      if (isSuccess) {
        AppDefaultDialogWidget()
            .setTitle(R.strings.success)
            .setContent(R.strings.sendRequestSuccess)
            .setAppDialogType(AppDialogType.success)
            .setPositiveText(R.strings.close)
            .buildDialog(AppKeys.navigatorKey.currentContext!)
            .show();
      }
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}

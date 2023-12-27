import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/notification/domain/usecases/delete_all_notification_uc.dart';
import 'package:app/features/notification/domain/usecases/delete_notification_by_id_uc.dart';
import 'package:app/features/notification/domain/usecases/get_list_notification_uc.dart';
import 'package:app/features/setting/domain/usecases/theme_language/get_language_uc.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:utilities/utilities.dart';

@Injectable()
class ListNotificationCubit extends AppListViewCubit<NotificationModel> {
  late final GetListNotificationUseCase _getListNotificationUseCase;
  late final DeleteNotificationByIdUseCase _deleteNotificationByIdUseCase;
  late final DeleteAllNotificationUseCase _deleteAllNotificationUseCase;
  late final GetLanguageUseCase _getLanguageUseCase;

  ListNotificationCubit(
    this._getListNotificationUseCase,
    this._deleteAllNotificationUseCase,
    this._deleteNotificationByIdUseCase,
  );

  @override
  Future<AppListResultModel<NotificationModel>> onCall(
      AppParam appParam) async {
    return _getListNotificationUseCase.executeList(
      request: GetListNotificationParam(
        page: appParam.page,
        pageSize: appParam.pageSize,
      ),
    );
  }

  Future<void> deleteAllNotifications() async {
    try {
      await _deleteAllNotificationUseCase.executeObj();
      await onRefreshCall();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }

  Future<void> deleteNotificationById(String id) async {
    try {
      await _deleteNotificationByIdUseCase.executeObj(
          request: DeleteNotificationByIdParam(id: id));
      await onRefreshCall();
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e);
          }).detected();
    }
  }
}

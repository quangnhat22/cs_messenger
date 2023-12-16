import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/user/domain/usecases/request/accept_request_uc.dart';
import 'package:app/features/user/domain/usecases/request/delete_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

part 'group_request_action_cubit.freezed.dart';
part 'group_request_action_state.dart';

@Injectable()
class GroupRequestActionCubit extends Cubit<GroupRequestActionState> {
  late final AcceptRequestUseCase _acceptRequestUseCase;
  late final DeleteRequestUseCase _deleteRequestUseCase;

  GroupRequestActionCubit(
      this._acceptRequestUseCase, this._deleteRequestUseCase)
      : super(const GroupRequestActionState.initial());

  Future<void> acceptRequest(String requestId) async {
    try {
      AppLoadingOverlayWidget.show();
      await _acceptRequestUseCase.executeObj(
          request: ActionRequestParam(id: requestId));
      AppSnackBarWidget()
          .setLabelText(R.strings.acceptRequestSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.errorOccurred)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }

  Future<void> rejectRequest(String requestId) async {
    try {
      AppLoadingOverlayWidget.show();
      await _deleteRequestUseCase.executeObj(
          request: ActionRequestParam(id: requestId));
      AppSnackBarWidget()
          .setLabelText(R.strings.rejectRequestSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.errorOccurred)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }

  Future<void> undoRequest(String requestId) async {
    try {
      AppLoadingOverlayWidget.show();
      await _deleteRequestUseCase.executeObj(
          request: ActionRequestParam(id: requestId));
      AppSnackBarWidget()
          .setLabelText(R.strings.undoRequestSuccess)
          .setAppSnackBarType(AppSnackBarType.informMessage)
          .setAppSnackBarStatus(AppSnackBarStatus.success)
          .showSnackBar();
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.errorOccurred)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
          }).detected();
    }
  }
}

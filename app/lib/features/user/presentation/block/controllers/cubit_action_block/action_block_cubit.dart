import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/features/user/domain/usecases/block/unblock_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

part 'action_block_cubit.freezed.dart';
part 'action_block_state.dart';

@Injectable()
class ActionBlockCubit extends Cubit<ActionBlockState> {
  late final UnBlockUserUseCase _unBlockUserUseCase;

  ActionBlockCubit(this._unBlockUserUseCase)
      : super(const ActionBlockState.initial());

  Future<void> unBlockUser(String userId) async {
    try {
      AppLoadingOverlayWidget.show();
      // await _unBlockUserUseCase.executeObj(
      //     request: ActionRequestParam(id: userId));
      AppSnackBarWidget()
          .setLabelText(R.strings.unBlockSuccess)
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

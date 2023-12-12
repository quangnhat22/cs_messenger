import 'package:app/components/main/overlay/app_loading_overlay_widget.dart';
import 'package:app/components/main/snackBar/app_snack_bar_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/features/friend/domain/usecases/delete_friend_uc.dart';
import 'package:app/features/user/domain/usecases/block/block_user_uc.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_info_by_id_uc.dart';
import 'package:app/features/user/domain/usecases/request/delete_request_uc.dart';
import 'package:app/features/user/domain/usecases/request/sent_request_uc.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part 'friend_info_cubit.freezed.dart';
part 'friend_info_state.dart';

@Injectable()
class FriendInfoCubit extends Cubit<FriendInfoState> {
  late final GetUserInfoByIdUseCase _getUserInfoByIdUseCase;
  late final BlockUserUseCase _blockUserUseCase;
  late final SentRequestUseCase _sentRequestUseCase;
  late final DeleteFriendUseCase _deleteFriendUseCase;
  late final DeleteRequestUseCase _deleteRequestUseCase;

  FriendInfoCubit(
    this._getUserInfoByIdUseCase,
    this._blockUserUseCase,
    this._sentRequestUseCase,
    this._deleteFriendUseCase,
    this._deleteRequestUseCase,
  ) : super(const FriendInfoState.initial());

  Future<void> initPage(String userId) async {
    try {
      AppLoadingOverlayWidget.show();
      final response = await _getUserInfoByIdUseCase.executeObj(
          request: ActionRequestParam(id: userId));
      emit(state.copyWith(userInfo: response.netData));
      AppLoadingOverlayWidget.dismiss();
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (_) {
            Logs.e(e.toString());
          }).detected();
    }
  }

  Future<void> deleteFriend() async {
    try {
      if (state.userInfo?.id != null) {
        AppLoadingOverlayWidget.show();
        await _deleteFriendUseCase.executeObj(
            request: ActionRequestParam(id: state.userInfo!.id));
        AppLoadingOverlayWidget.dismiss();
        AppSnackBarWidget()
            .setLabelText(R.strings.unFriendSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e.toString());
          }).detected();
    }
  }

  Future<void> blockFriend() async {
    try {
      if (state.userInfo?.id != null) {
        AppLoadingOverlayWidget.show();
        await _blockUserUseCase.executeObj(
            request: ActionRequestParam(id: state.userInfo!.id));
        AppLoadingOverlayWidget.dismiss();
        AppSnackBarWidget()
            .setLabelText(R.strings.blockSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e.toString());
          }).detected();
    }
  }

  Future<void> addFriend() async {
    try {
      if (state.userInfo?.id != null) {
        AppLoadingOverlayWidget.show();
        await _sentRequestUseCase.executeObj(
            request: SentRequestParam(userId: state.userInfo!.id));
        AppLoadingOverlayWidget.dismiss();
        AppSnackBarWidget()
            .setLabelText(R.strings.sendRequestSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e.toString());
          }).detected();
    }
  }

  Future<void> undoFriendRequest() async {
    try {
      if (state.userInfo?.id != null) {
        AppLoadingOverlayWidget.show();
        await _deleteRequestUseCase.executeObj(
            request: ActionRequestParam(id: state.userInfo!.id));
        AppLoadingOverlayWidget.dismiss();
        AppSnackBarWidget()
            .setLabelText(R.strings.undoRequestSuccess)
            .setAppSnackBarType(AppSnackBarType.informMessage)
            .setAppSnackBarStatus(AppSnackBarStatus.success)
            .showSnackBar();
      }
    } on AppException catch (e) {
      AppLoadingOverlayWidget.dismiss();
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.e(e.toString());
          }).detected();
    }
  }
}

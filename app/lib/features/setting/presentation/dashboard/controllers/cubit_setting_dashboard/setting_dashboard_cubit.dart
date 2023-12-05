import 'dart:async';

import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/logout_uc.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_profile_local_uc.dart';
import 'package:app/features/user/domain/usecases/profile/update_user_profile_uc.dart';
import 'package:app/service/firebase/upload_file_exts.dart';
import 'package:domain/domain.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';

part 'setting_dashboard_cubit.freezed.dart';
part 'setting_dashboard_state.dart';

@Injectable()
class SettingDashboardCubit extends Cubit<SettingDashboardState> {
  late final LogOutUseCase _logOutUseCase;
  late final GetUserProfileLocalUseCase _getUserProfileLocalUseCase;
  late final UpdateUserProfileUseCase _updateUserSelfUseCase;

  SettingDashboardCubit(
    this._logOutUseCase,
    this._getUserProfileLocalUseCase,
    this._updateUserSelfUseCase,
  ) : super(const SettingDashboardState.initial());

  late StreamSubscription<UserModel?> userLocalSub;

  Future<void> initPage() async {
    try {
      userLocalSub =
          _getUserProfileLocalUseCase.getStream().listen((userModel) {
        emit(state.copyWith(userInfo: userModel));
      });
      final userModel = await _getUserProfileLocalUseCase.executeObj();
      emit(state.copyWith(userInfo: userModel.netData));
    } on AppException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _logOutUseCase.executeObj();
      await getIt<AppRouter>().replace(const WelcomeRoute());
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.logOutFail)
                .setContent(R.strings.errorOccurred)
                .setPositiveText(R.strings.confirm)
                .show();
          }).detected();
    }
  }

  Future<void> updateAvatar(String avatar) async {
    try {
      final UploadTask? uploadTask = UploadFileExts.uploadFile(avatar);
      uploadTask!.snapshotEvents.listen(
        (taskSnapShot) => UploadFileExts.handleSnapShot(taskSnapShot).then(
          (path) async {
            if (path != null) {
              await _updateUserSelfUseCase.executeObj(
                  request: UpdateUserSelfParam(avatar: path));
            }
          },
        ),
      );
    } on AppException catch (e) {
      AppExceptionExt(
          appException: e,
          onError: (_) {
            AppDefaultDialogWidget()
                .setTitle(R.strings.logOutFail)
                .setContent(R.strings.errorOccurred)
                .setPositiveText(R.strings.confirm)
                .show();
          }).detected();
    }
  }
}

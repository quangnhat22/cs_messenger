import 'package:app/components/main/dialog/app_dialog_base_builder.dart';
import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:app/configs/routes/app_router.dart';
import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/check_authenticated_uc.dart';
import 'package:app/features/auth/domain/usecases/auth/login_with_google_uc.dart';
import 'package:app/features/auth/domain/usecases/email/get_verify_email_token_uc.dart';
import 'package:app/features/auth/domain/usecases/onboarding/get_id_remote_device.dart';
import 'package:app/features/auth/domain/usecases/onboarding/get_is_first_installed_uc.dart';
import 'package:app/features/auth/domain/usecases/onboarding/register_device_uc.dart';
import 'package:app/features/user/domain/usecases/profile/get_user_profile_uc.dart';
import 'package:app/service/socket/socket_service.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:utilities/utilities.dart';

part 'welcome_bloc.freezed.dart';
part 'welcome_event.dart';
part 'welcome_state.dart';

@Injectable()
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  late final GetIsFirstInstalledUseCase _getIsFirstInstalledUseCase;
  late final GetIdRemoteDeviceUseCase _getIdRemoteDeviceUseCase;
  late final RegisterDeviceUseCase _registerDeviceUseCase;
  late final CheckAuthenticatedUseCase _checkAuthenticatedUseCase;
  late final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  late final GetVerifyEmailTokenUseCase _getVerifyEmailTokenUseCase;
  late final GetUserProfileUseCase _getUserProfileUseCase;

  WelcomeBloc(
    this._getIsFirstInstalledUseCase,
    this._loginWithGoogleUseCase,
    this._getIdRemoteDeviceUseCase,
    this._checkAuthenticatedUseCase,
    this._registerDeviceUseCase,
    this._getVerifyEmailTokenUseCase,
    this._getUserProfileUseCase,
  ) : super(const WelcomeState.initial()) {
    on<WelcomeEvent>((event, emit) async {
      await event.map(
        started: (event) async => await _started(event, emit),
        loginWithGoogle: (event) async => await _loginWithGoogle(event, emit),
        checkAuthenticated: (event) async =>
            await _checkAuthenticated(event, emit),
      );
    });
  }

  Future<void> _started(_Started event, Emitter<WelcomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      getIt<SocketService>().socketDisconnected();

      final welcomeModel = await _getIsFirstInstalledUseCase.executeObj();
      final idRemoteDeviceModel = await _getIdRemoteDeviceUseCase.executeObj();

      final isFirstInstall = welcomeModel.netData?.isFirstInstall ?? true;
      final isHasDeviceId = idRemoteDeviceModel.netData?.id != null &&
          idRemoteDeviceModel.netData?.id != '';

      if (isFirstInstall) {
        emit(state.copyWith(isFirstInstall: isFirstInstall));
      } else {
        if (!isHasDeviceId) {
          await _registerDeviceUseCase.executeObj();
        }

        final isVerifyEmail = await _checkIsVerifyingEmail();

        if (isVerifyEmail) {
          //open verify email page
          await getIt<AppRouter>()
              .push(VerifyEmailRoute(isFirstRequestSendEmail: false));
        } else {
          add(const WelcomeCheckLoginAuthenticated());
          // final isAuthenticated = await _checkAuthenticated();
          // emit(state.copyWith(isAuthenticated: isAuthenticated));
        }
      }
      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      emit(state.copyWith(isLoading: false));
      AppExceptionExt(
        appException: e,
        onError: (_) {
          AppDefaultDialogWidget()
              .setTitle(R.strings.error)
              .setContent(R.strings.systemIsCurrentlyErrorPleaseTryAgainLater)
              .setAppDialogType(AppDialogType.error)
              .setNegativeText(R.strings.close)
              .setPositiveText(R.strings.confirm)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        },
      ).detected();
    }
  }

  Future<void> _loginWithGoogle(
      WelcomeLoginWithGoogle event, Emitter<WelcomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _loginWithGoogleUseCase.executeObj();
      add(const WelcomeEvent.checkAuthenticated());
      // final isAuthenticated = await _checkAuthenticated();
      // emit(state.copyWith(isAuthenticated: isAuthenticated));
      emit(state.copyWith(isLoading: false));
    } on AppException catch (e) {
      emit(state.copyWith(isLoading: false));
      AppExceptionExt(
        appException: e,
        onError: (_) {},
      ).detected();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<bool> _checkIsVerifyingEmail() async {
    try {
      final verifyEmailToken = await _getVerifyEmailTokenUseCase.executeObj();
      return verifyEmailToken.netData?.token?.accessToken != null &&
          verifyEmailToken.netData!.token!.accessToken!.isNotEmpty &&
          verifyEmailToken.netData?.email != null;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _checkAuthenticated(
      WelcomeCheckLoginAuthenticated event, Emitter<WelcomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final tokenModel = await _checkAuthenticatedUseCase.executeObj();
      if (tokenModel.netData?.accessToken != '') {
        getIt<SocketService>().connectSocket();
        await _getUserProfileUseCase.executeObj();
        emit(state.copyWith(isAuthenticated: true, isLoading: false));
      }
      emit(state.copyWith(isAuthenticated: false, isLoading: false));
    } on AppException catch (e) {
      emit(state.copyWith(isAuthenticated: false, isLoading: false));
      AppExceptionExt(
          appException: e,
          onError: (e) {
            Logs.d(e);
          }).detected();
    }
  }
}

part of 'app_exts.dart';

class AppExceptionExt {
  late final AppException? appException;
  final Function(AppException appException)? onError;

  AppExceptionExt({required this.appException, this.onError});

  void detected() {
    if (appException == null) {
      return AppDefaultDialogWidget()
          .setTitle('Dialog Error')
          .setContent('Application Error')
          .setAppDialogType(AppDialogType.error)
          .setPositiveText(R.strings.confirm)
          .setNegativeText(R.strings.close)
          .buildDialog(AppKeys.navigatorKey.currentContext!)
          .show();
    }
    if (appException is NetworkException) {
      // General Code
      switch (appException?.code) {
        case HttpStatus.unauthorized:
          // Force Logout
          return AppDefaultDialogWidget()
              .setTitle(R.strings.pleaseLoginAgain)
              .setContent(appException?.message)
              .setPositiveText(R.strings.confirm)
              .setAppDialogType(AppDialogType.error)
              .setOnPositive(() async {
                await _handleForceLogOut();
              })
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        case HttpStatus.badRequest:
        case HttpStatus.internalServerError:
        case HttpStatus.serviceUnavailable:
          return AppDefaultDialogWidget()
              .setTitle(R.strings.error)
              .setContent(appException?.message ??
                  R.strings.systemIsCurrentlyErrorPleaseTryAgainLater)
              .setAppDialogType(AppDialogType.error)
              .setPositiveText(R.strings.confirm)
              .setNegativeText(R.strings.close)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        case HttpStatus.gatewayTimeout:
        case HttpStatus.badGateway:
          return AppDefaultDialogWidget()
              .setTitle('Dialog Error: ${appException?.code}')
              .setContent(appException?.message)
              .setAppDialogType(AppDialogType.error)
              .setPositiveText(R.strings.confirm)
              .setNegativeText(R.strings.close)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        case HttpStatus.conflict:
          return AppDefaultDialogWidget()
              .setTitle(R.strings.error)
              .setContent(_getExceptionMessage(appException?.errorCode) ??
                  R.strings.dataConflict)
              .setAppDialogType(AppDialogType.error)
              .setPositiveText(R.strings.confirm)
              .setNegativeText(R.strings.close)
              .buildDialog(AppKeys.navigatorKey.currentContext!)
              .show();
        //force change password
        case HttpStatus.locked:
          //ForceChangePasswordPage.open();
          break;
        default:
          onError?.call(appException!);
          return;
      }
    }

    if (appException is GrpcException) {
      switch (appException!.errorCode) {
        case "5":
          {
            AppDefaultDialogWidget()
                .setTitle(R.strings.loginFail)
                .setContent(R.strings.emailOrPasswordWrong)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
            break;
          }
        case "14":
          {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.systemIsCurrentlyErrorPleaseTryAgainLater)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
            break;
          }
        case "16":
          {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.loginInExpired)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .setOnPositive(() async {
                  _handleForceLogOut();
                })
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
            break;
          }

        case "17":
          {
            AppDefaultDialogWidget()
                .setTitle(R.strings.error)
                .setContent(R.strings.systemIsCurrentlyErrorPleaseTryAgainLater)
                .setAppDialogType(AppDialogType.error)
                .setNegativeText(R.strings.close)
                .setPositiveText(R.strings.confirm)
                .buildDialog(AppKeys.navigatorKey.currentContext!)
                .show();
            getIt<AppRouter>()
                .replace(VerifyEmailRoute(isFirstRequestSendEmail: true));
            break;
          }
      }
      Logs.d(
          'GrpcException: ${appException?.message} - ${appException?.code} - ${appException?.errorCode}');
    }

    if (appException is LocalException) {
      Logs.d('LocalException: ${appException?.message}');
      onError?.call(appException!);
    }
  }

  String? _getExceptionMessage(String? errorCode) {
    if (errorCode == null) {
      return null;
    }

    // switch (errorCode) {
    //   case 'USER_003':
    //     return R.strings.emailOrCitizenIdNoHasAlreadyExistedPleaseCheckAgain;
    // }

    return null;
  }

  Future<void> _handleForceLogOut() async {
    try {
      final forceLogOutUseCase = getIt<ForceLogOutUseCase>();
      await forceLogOutUseCase.executeObj();
      await getIt<AppRouter>().replace(const WelcomeRoute());
    } on LocalException catch (e) {
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
          }).detected();
    }
  }
}

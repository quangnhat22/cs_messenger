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
    // try {
    //   final forceLogOutUseCase = Get.find<ForceLogOutUseCase>();
    //   await forceLogOutUseCase.executeObj();
    //   Get.offAllNamed(Routes.welcome);
    // } on LocalException catch (e) {
    //   AppExceptionExt(appException: e).detected();
    // }
  }
}

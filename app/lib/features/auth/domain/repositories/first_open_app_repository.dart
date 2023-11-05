import 'package:domain/domain.dart';

abstract class FirstOpenAppRepository {
  Future<AppObjResultModel<WelcomeModel>> checkIsFirstInstall();

  Future<AppObjResultModel<EmptyModel>> updateValueFirstInstall();
}

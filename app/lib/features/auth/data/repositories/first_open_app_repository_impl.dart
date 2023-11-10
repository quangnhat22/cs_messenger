import 'package:app/features/auth/data/sources/local/first_install_app_local_data_src.dart';
import 'package:app/features/auth/domain/repositories/first_open_app_repository.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirstOpenAppRepository)
class FirstOpenAppRepositoryImpl implements FirstOpenAppRepository {
  late final FirstInstallAppLocalDataSource _numberInstallAppDataSource;

  FirstOpenAppRepositoryImpl(this._numberInstallAppDataSource);

  @override
  Future<AppObjResultModel<WelcomeModel>> checkIsFirstInstall() async {
    try {
      final isFirstInstallApp =
          await _numberInstallAppDataSource.getIsFirstInstall();
      return Future.value(
        AppObjResultRaw(netData: WelcomeRaw(isFirstInstall: isFirstInstallApp))
            .raw2Model(),
      );
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateValueFirstInstall() async {
    try {
      await _numberInstallAppDataSource.updateIsFirstInstall();
      return Future.value(
        AppObjResultRaw(netData: EmptyRaw()).raw2Model(),
      );
    } on LocalException catch (_) {
      rethrow;
    }
  }
}

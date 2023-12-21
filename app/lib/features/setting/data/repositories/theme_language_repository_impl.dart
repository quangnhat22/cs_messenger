import 'package:app/features/setting/data/sources/local/theme_language_local_data_src.dart';
import 'package:app/features/setting/domain/repositories/theme_language_repository.dart';
import 'package:app/service/onesignal/onesignal_service.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ThemeLanguageRepository)
class ThemeLanguageRepositoryImpl extends ThemeLanguageRepository {
  late final OneSignalService _oneSignalService;
  late final ThemeLanguageLocalDataSrc _local;

  ThemeLanguageRepositoryImpl(this._local, this._oneSignalService);

  @override
  Future<AppObjResultModel<EmptyModel>> setLanguage(
      {required Map<String, dynamic> query}) async {
    try {
      // await _oneSignalService.setLanguage(query['value']);
      await _local.setLanguage(query['value']);
      return AppObjResultModel(netData: EmptyModel());
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<LanguageModel>> getLanguage() async {
    try {
      final themeLocal = await _local.getLanguage();
      return AppObjResultModel(
        netData: LanguageModel(
            language: LanguageType.convertStringToThemeType(themeLocal)),
      );
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Stream<LanguageModel> getStreamLanguage() {
    return _local.getLanguageStream().map((language) => LanguageModel(
        language: LanguageType.convertStringToThemeType(language)));
  }

  @override
  Future<AppObjResultModel<EmptyModel>> setTheme(
      {required Map<String, dynamic> query}) async {
    try {
      await _local.setTheme(query['value']);
      return AppObjResultModel(netData: EmptyModel());
    } on LocalException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<ThemeModel>> getTheme() async {
    try {
      final themeLocal = await _local.getTheme();
      return AppObjResultModel(
        netData:
            ThemeModel(theme: ThemeType.convertStringToThemeType(themeLocal)),
      );
    } on LocalException catch (e) {
      rethrow;
    }
  }

  @override
  Stream<ThemeModel> getStreamTheme() {
    return _local.getThemeStream().map((theme) =>
        ThemeModel(theme: ThemeType.convertStringToThemeType(theme)));
  }
}

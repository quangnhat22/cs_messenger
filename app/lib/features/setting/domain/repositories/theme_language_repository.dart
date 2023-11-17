import 'package:domain/domain.dart';

abstract class ThemeLanguageRepository {
  Future<AppObjResultModel<EmptyModel>> setLanguage(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> setTheme(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<LanguageModel>> getLanguage();

  Future<AppObjResultModel<ThemeModel>> getTheme();

  Stream<ThemeModel> getStreamTheme();

  Stream<LanguageModel> getStreamLanguage();
}

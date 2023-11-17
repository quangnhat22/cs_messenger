import 'package:app/features/setting/domain/repositories/theme_language_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetThemeUseCase extends BaseUseCase<BaseParam, ThemeModel> {
  Stream<ThemeModel> getStream();
}

@Injectable(as: GetThemeUseCase)
class GetThemeUseCaseImpl extends GetThemeUseCase {
  final ThemeLanguageRepository _repo;

  GetThemeUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<ThemeModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.getTheme();

  @override
  Stream<ThemeModel> getStream() => _repo.getStreamTheme();
}

import 'package:app/features/setting/domain/repositories/theme_language_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SetThemeUseCase
    extends BaseUseCase<ThemeAndLanguageParam, EmptyModel> {}

@Injectable(as: SetThemeUseCase)
class SetThemeUseCaseImpl extends SetThemeUseCase {
  final ThemeLanguageRepository _repo;

  SetThemeUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ThemeAndLanguageParam? request}) async =>
      await _repo.setTheme(query: request?.toJson() ?? {});
}

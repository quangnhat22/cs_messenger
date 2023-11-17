import 'package:app/features/setting/domain/repositories/theme_language_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class SetLanguageUseCase
    extends BaseUseCase<ThemeAndLanguageParam, EmptyModel> {}

@Injectable(as: SetLanguageUseCase)
class SetThemeUseCaseImpl extends SetLanguageUseCase {
  final ThemeLanguageRepository _repo;

  SetThemeUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<EmptyModel>> executeObj(
          {ThemeAndLanguageParam? request}) async =>
      await _repo.setLanguage(query: request?.toJson() ?? {});
}

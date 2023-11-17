import 'package:app/features/setting/domain/repositories/theme_language_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

abstract class GetLanguageUseCase
    extends BaseUseCase<BaseParam, LanguageModel> {
  Stream<LanguageModel> getStream();
}

@Injectable(as: GetLanguageUseCase)
class GetLanguageUseCaseImpl extends GetLanguageUseCase {
  final ThemeLanguageRepository _repo;

  GetLanguageUseCaseImpl(this._repo);

  @override
  Future<AppObjResultModel<LanguageModel>> executeObj(
          {BaseParam? request}) async =>
      await _repo.getLanguage();

  @override
  Stream<LanguageModel> getStream() => _repo.getStreamLanguage();
}

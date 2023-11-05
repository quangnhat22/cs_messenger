import 'package:app/configs/routes/app_router.gr.dart';
import 'package:app/features/auth/domain/usecases/auth/check_authenticated_usecase.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthGuard extends AutoRouteGuard {
  late final CheckAuthenticatedUseCase _checkAuthenticatedUseCase;

  AuthGuard(this._checkAuthenticatedUseCase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final _tokenModel = await _checkAuthenticatedUseCase.executeObj();
    if (true) {
      resolver.next();
    } else {
      resolver.redirect(const WelcomeRoute());
      // router.push(WelcomeRoute());
    }
  }
}

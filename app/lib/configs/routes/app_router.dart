import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Page|Screen|View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: UIKitDemoRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(page: RoomChatDashBoardRoute.page),
            AutoRoute(
              page: FriendDashBoardRoute.page,
              children: [
                AutoRoute(page: FriendListCallHistoryRoute.page),
                AutoRoute(page: FriendListRoute.page),
              ],
            ),
            AutoRoute(page: GroupDashBoardRoute.page),
            AutoRoute(page: SettingDashBoardRoute.page),
          ],
        ),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: FriendAddNewContactRoute.page),
        AutoRoute(page: FriendRequestRoute.page, children: [
          AutoRoute(page: FriendSentRequestRoute.page),
          AutoRoute(page: FriendReceivedRequestRoute.page),
        ]),
        AutoRoute(page: GroupCreateRoute.page),
        AutoRoute(page: GroupRequestRoute.page),
      ];
}

import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';
import 'guard/auth_guard.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Page|Screen|View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WelcomeRoute.page,
          initial: true,
        ),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: VerifyEmailRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: SendEmailSuccessRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(
          page: MainRoute.page,
          guards: [getIt<AuthGuard>()],
          children: [
            AutoRoute(
              page: HomeRoute.page,
              initial: true,
              children: [
                _customRoute(page: RoomChatDashBoardRoute.page),
                _customRoute(
                  page: FriendDashBoardRoute.page,
                  children: [
                    _customRoute(page: FriendListCallHistoryRoute.page),
                    _customRoute(page: FriendListRoute.page),
                  ],
                ),
                _customRoute(page: GroupDashBoardRoute.page),
                _customRoute(page: SettingDashBoardRoute.page),
              ],
            ),
            _customRoute(
              page: FriendRequestRoute.page,
              children: [
                _customRoute(page: FriendSentRequestRoute.page),
                _customRoute(page: FriendReceivedRequestRoute.page),
              ],
            ),
            _customRoute(page: FriendInfoRoute.page),
            _customRoute(page: SearchRoute.page),
            _customRoute(page: GroupCreateRoute.page),
            _customRoute(
              page: GroupRequestRoute.page,
              children: [
                _customRoute(page: GroupSentRequestRoute.page),
                _customRoute(page: GroupReceivedRequestRoute.page),
              ],
            ),
            _customRoute(page: EditProfileRoute.page),
            _customRoute(page: ThemeAndLanguageRoute.page),
            _customRoute(page: NotificationSettingRoute.page),
            _customRoute(page: ListDevicesRoute.page),
            _customRoute(page: ChangePasswordRoute.page),
            _customRoute(page: BlockRoute.page),
            _customRoute(page: ChatRoute.page),
            _customRoute(page: PersonalDetailChatRoomRoute.page),
            _customRoute(page: GroupDetailChatRoomRoute.page),
          ],
        )
      ];

  CustomRoute _customRoute(
      {required PageInfo<dynamic> page, List<AutoRoute>? children}) {
    return CustomRoute(
        page: page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: AppNavigationKeys.timeSwitchPage,
        children: children);
  }
}

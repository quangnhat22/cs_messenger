import 'package:app/configs/di/di.dart';
import 'package:app/configs/exts/app_exts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        _customRoute(page: OnboardingRoute.page),
        _customRoute(page: LoginRoute.page),
        _customRoute(page: VerifyEmailRoute.page),
        _customRoute(page: ForgotPasswordRoute.page),
        _customRoute(page: SendEmailSuccessRoute.page),
        _customRoute(page: SignUpRoute.page),
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
            _customRoute(page: GroupMemberRoute.page),
            _customRoute(page: RoomChatMediaRoute.page, children: [
              _customRoute(page: RoomImageRoute.page),
              _customRoute(page: RoomVideoRoute.page),
              _customRoute(page: RoomFileRoute.page),
            ]),
            _customRoute(
                page: VideoCallRoute.page,
                customRouteBuilder: modalSheetBuilder,
                children: [
                  _customRoute(page: ChatRoute.page),
                ]),
            _customRoute(page: ListNotificationRoute.page),
          ],
        )
      ];

  CustomRoute _customRoute(
      {required PageInfo<dynamic> page,
      List<AutoRoute>? children,
      Route<T> Function<T>(BuildContext, Widget, AutoRoutePage<T>)?
          customRouteBuilder}) {
    return CustomRoute(
        page: page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        durationInMilliseconds: AppNavigationKeys.timeSwitchPage,
        children: children,
        customRouteBuilder: customRouteBuilder);
  }

  Route<T> modalSheetBuilder<T>(
      BuildContext context, Widget child, AutoRoutePage<T> page) {
    return ModalBottomSheetRoute(
      settings: page,
      builder: (context) => child,
      isScrollControlled: true,
    );
  }
}

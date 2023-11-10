// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `Vietnamese`
  String get language {
    return Intl.message(
      'Vietnamese',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Quay lại`
  String get back {
    return Intl.message(
      'Quay lại',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ qua`
  String get skip {
    return Intl.message(
      'Bỏ qua',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Tiếp tục`
  String get next {
    return Intl.message(
      'Tiếp tục',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng đến với {app}`
  String welcomeToApp(String app) {
    return Intl.message(
      'Chào mừng đến với $app',
      name: 'welcomeToApp',
      desc: '',
      args: [app],
    );
  }

  /// `Khám phá tính năng nhắn tin mượt mà và cuộc gọi video chất lượng cao. Giữ kết nối với bạn bè và người thân một cách dễ dàng chưa từng có.`
  String get discoverSeamlessMessaging {
    return Intl.message(
      'Khám phá tính năng nhắn tin mượt mà và cuộc gọi video chất lượng cao. Giữ kết nối với bạn bè và người thân một cách dễ dàng chưa từng có.',
      name: 'discoverSeamlessMessaging',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối với bạn bè ở mọi lúc, mọi Nơi`
  String get connectingPeopleAnytimeAnywhere {
    return Intl.message(
      'Kết nối với bạn bè ở mọi lúc, mọi Nơi',
      name: 'connectingPeopleAnytimeAnywhere',
      desc: '',
      args: [],
    );
  }

  /// `Trải nghiệm sức mạnh của việc nhắn tin tức thời và cuộc gọi video rõ nét. Kết nối với mọi người trên toàn thế giới dễ dàng.`
  String get experienceThePower {
    return Intl.message(
      'Trải nghiệm sức mạnh của việc nhắn tin tức thời và cuộc gọi video rõ nét. Kết nối với mọi người trên toàn thế giới dễ dàng.',
      name: 'experienceThePower',
      desc: '',
      args: [],
    );
  }

  /// `Khoảng cách không là vấn đề`
  String get stayCloseNoMatterDistance {
    return Intl.message(
      'Khoảng cách không là vấn đề',
      name: 'stayCloseNoMatterDistance',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ qua khoảng cách với {app}. Chia sẻ những kỉ niệm, gửi tin nhắn và video call, bất kể bạn đang ở đâu.`
  String bridgeTheGap(String app) {
    return Intl.message(
      'Bỏ qua khoảng cách với $app. Chia sẻ những kỉ niệm, gửi tin nhắn và video call, bất kể bạn đang ở đâu.',
      name: 'bridgeTheGap',
      desc: '',
      args: [app],
    );
  }

  /// `Chào mừng bạn trở lại!`
  String get welcomeBack {
    return Intl.message(
      'Chào mừng bạn trở lại!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập để kết nối với bạn bè`
  String get signInYourAccountToSeeYourChatting {
    return Intl.message(
      'Đăng nhập để kết nối với bạn bè',
      name: 'signInYourAccountToSeeYourChatting',
      desc: '',
      args: [],
    );
  }

  /// `Chào mừng bạn`
  String get welcome {
    return Intl.message(
      'Chào mừng bạn',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản để bắt đầu kết nối với những người bạn`
  String get startChattingWithANewAccount {
    return Intl.message(
      'Tạo tài khoản để bắt đầu kết nối với những người bạn',
      name: 'startChattingWithANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu`
  String get password {
    return Intl.message(
      'Mật khẩu',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu`
  String get confirmPassword {
    return Intl.message(
      'Xác nhận mật khẩu',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Quên mật khẩu`
  String get forgotPassword {
    return Intl.message(
      'Quên mật khẩu',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký`
  String get register {
    return Intl.message(
      'Đăng ký',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Gửi email thành công`
  String get sendEmailSuccess {
    return Intl.message(
      'Gửi email thành công',
      name: 'sendEmailSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Bạn hãy kiểm tra email để khôi phục mật khẩu nhé`
  String get pleaseCheckYourEmailToRecovery {
    return Intl.message(
      'Bạn hãy kiểm tra email để khôi phục mật khẩu nhé',
      name: 'pleaseCheckYourEmailToRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Trở về trang chính`
  String get backToWelcome {
    return Intl.message(
      'Trở về trang chính',
      name: 'backToWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Mở ứng dụng Email`
  String get openEmailApp {
    return Intl.message(
      'Mở ứng dụng Email',
      name: 'openEmailApp',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Đóng`
  String get close {
    return Intl.message(
      'Đóng',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng đăng nhập lại`
  String get pleaseLoginAgain {
    return Intl.message(
      'Vui lòng đăng nhập lại',
      name: 'pleaseLoginAgain',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi`
  String get error {
    return Intl.message(
      'Lỗi',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống đang lỗi, vui lòng thử lại sau`
  String get systemIsCurrentlyErrorPleaseTryAgainLater {
    return Intl.message(
      'Hệ thống đang lỗi, vui lòng thử lại sau',
      name: 'systemIsCurrentlyErrorPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi xảy ra! Vui lòng thử lại sau.`
  String get errorOccurred {
    return Intl.message(
      'Đã có lỗi xảy ra! Vui lòng thử lại sau.',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Dữ liệu đã tồn tại`
  String get dataConflict {
    return Intl.message(
      'Dữ liệu đã tồn tại',
      name: 'dataConflict',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn đăng xuất?`
  String get doYouWantToLogOut {
    return Intl.message(
      'Bạn có muốn đăng xuất?',
      name: 'doYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Input không hợp lệ`
  String get invalidInput {
    return Intl.message(
      'Input không hợp lệ',
      name: 'invalidInput',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Bạn bè`
  String get friends {
    return Intl.message(
      'Bạn bè',
      name: 'friends',
      desc: '',
      args: [],
    );
  }

  /// `Nhóm`
  String get groups {
    return Intl.message(
      'Nhóm',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get settings {
    return Intl.message(
      'Cài đặt',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// ` Không có dữ liệu!`
  String get noData {
    return Intl.message(
      ' Không có dữ liệu!',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Thử lại`
  String get retry {
    return Intl.message(
      'Thử lại',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi hệ thống`
  String get serverError {
    return Intl.message(
      'Lỗi hệ thống',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm`
  String get search {
    return Intl.message(
      'Tìm kiếm',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Cuộc gọi gần đây`
  String get recentCall {
    return Intl.message(
      'Cuộc gọi gần đây',
      name: 'recentCall',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách bạn bè`
  String get listFriend {
    return Intl.message(
      'Danh sách bạn bè',
      name: 'listFriend',
      desc: '',
      args: [],
    );
  }

  /// `Thêm liên hệ mới`
  String get addNewContact {
    return Intl.message(
      'Thêm liên hệ mới',
      name: 'addNewContact',
      desc: '',
      args: [],
    );
  }

  /// `Lời mời kết bạn`
  String get requestFriend {
    return Intl.message(
      'Lời mời kết bạn',
      name: 'requestFriend',
      desc: '',
      args: [],
    );
  }

  /// `Tìm kiếm bạn bè`
  String get searchFriend {
    return Intl.message(
      'Tìm kiếm bạn bè',
      name: 'searchFriend',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhóm mới`
  String get createNewGroup {
    return Intl.message(
      'Tạo nhóm mới',
      name: 'createNewGroup',
      desc: '',
      args: [],
    );
  }

  /// `Lời mời nhóm`
  String get requestGroup {
    return Intl.message(
      'Lời mời nhóm',
      name: 'requestGroup',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối với "network" của bạn`
  String get getConnectWithYourFriends {
    return Intl.message(
      'Kết nối với "network" của bạn',
      name: 'getConnectWithYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập với email`
  String get signInWithEmail {
    return Intl.message(
      'Đăng nhập với email',
      name: 'signInWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập với Google`
  String get signInWithGoogle {
    return Intl.message(
      'Đăng nhập với Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký với email`
  String get signUpWithEmail {
    return Intl.message(
      'Đăng ký với email',
      name: 'signUpWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Địa chỉ email khong hợp lệ.`
  String get emailValidate {
    return Intl.message(
      'Địa chỉ email khong hợp lệ.',
      name: 'emailValidate',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu phải có ít nhất 8 ký tự và chứa ít nhất 1 chữ cái, 1 số và 1 ký tự đặc biệt. (e.g @,#,$,...)`
  String get passwordValidate {
    return Intl.message(
      'Mật khẩu phải có ít nhất 8 ký tự và chứa ít nhất 1 chữ cái, 1 số và 1 ký tự đặc biệt. (e.g @,#,\$,...)',
      name: 'passwordValidate',
      desc: '',
      args: [],
    );
  }

  /// `Hiểu rồi`
  String get gotIt {
    return Intl.message(
      'Hiểu rồi',
      name: 'gotIt',
      desc: '',
      args: [],
    );
  }

  /// `Tạo tài khoản thành công! Vui lòng đăng nhập để tiếp tục.`
  String get createAccountSuccess {
    return Intl.message(
      'Tạo tài khoản thành công! Vui lòng đăng nhập để tiếp tục.',
      name: 'createAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Hoặc`
  String get or {
    return Intl.message(
      'Hoặc',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu không trùng với Mật khẩu`
  String get confirmPasswordNotMatch {
    return Intl.message(
      'Xác nhận mật khẩu không trùng với Mật khẩu',
      name: 'confirmPasswordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Xác minh email`
  String get verifyYourEmail {
    return Intl.message(
      'Xác minh email',
      name: 'verifyYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Vui lòng mở "{email}" để xác minh tài khoản. Vui lòng xác nhận tài khoản trước ${expireTime}, nếu không tài khoản của bạn có thể bị mất!`
  String pleaseCheckYourEmail(String email, String expireTime) {
    return Intl.message(
      'Vui lòng mở "$email" để xác minh tài khoản. Vui lòng xác nhận tài khoản trước \$$expireTime, nếu không tài khoản của bạn có thể bị mất!',
      name: 'pleaseCheckYourEmail',
      desc: '',
      args: [email, expireTime],
    );
  }

  /// `Đăng xuất`
  String get logOut {
    return Intl.message(
      'Đăng xuất',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Gửi email`
  String get sendEmail {
    return Intl.message(
      'Gửi email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lại email sau`
  String get resendEmailAfter {
    return Intl.message(
      'Gửi lại email sau',
      name: 'resendEmailAfter',
      desc: '',
      args: [],
    );
  }

  /// `Bạn vui lòng nhập email đã đăng ký bên dưới, và chúng tôi sẽ gửi hướng dẫn khôi phục mật khẩu đến cho bạn`
  String get registerEmailToReceivePasswordReset {
    return Intl.message(
      'Bạn vui lòng nhập email đã đăng ký bên dưới, và chúng tôi sẽ gửi hướng dẫn khôi phục mật khẩu đến cho bạn',
      name: 'registerEmailToReceivePasswordReset',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

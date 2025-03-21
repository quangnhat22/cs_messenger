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

  /// `Vui lòng mở "{email}" để xác minh tài khoản. Vui lòng xác nhận tài khoản trước {expireTime}, nếu không tài khoản của bạn có thể bị mất!`
  String pleaseCheckYourEmail(String email, String expireTime) {
    return Intl.message(
      'Vui lòng mở "$email" để xác minh tài khoản. Vui lòng xác nhận tài khoản trước $expireTime, nếu không tài khoản của bạn có thể bị mất!',
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

  /// `Chủ đề và ngôn ngữ`
  String get themeAndLanguage {
    return Intl.message(
      'Chủ đề và ngôn ngữ',
      name: 'themeAndLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Chủ đề`
  String get theme {
    return Intl.message(
      'Chủ đề',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Ngôn ngữ`
  String get language {
    return Intl.message(
      'Ngôn ngữ',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Chế độ sáng`
  String get lightMode {
    return Intl.message(
      'Chế độ sáng',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Chế độ tối`
  String get darkMode {
    return Intl.message(
      'Chế độ tối',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống`
  String get system {
    return Intl.message(
      'Hệ thống',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Việt`
  String get vn {
    return Intl.message(
      'Tiếng Việt',
      name: 'vn',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Anh`
  String get en {
    return Intl.message(
      'Tiếng Anh',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách thiết bị`
  String get devices {
    return Intl.message(
      'Danh sách thiết bị',
      name: 'devices',
      desc: '',
      args: [],
    );
  }

  /// `Về chúng tôi`
  String get about {
    return Intl.message(
      'Về chúng tôi',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Xóa tài khoản`
  String get deleteAccount {
    return Intl.message(
      'Xóa tài khoản',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notification {
    return Intl.message(
      'Thông báo',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Bật/tắt mở thông báo`
  String get turnOnOffNotification {
    return Intl.message(
      'Bật/tắt mở thông báo',
      name: 'turnOnOffNotification',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị hiện tại`
  String get currentDevices {
    return Intl.message(
      'Thiết bị hiện tại',
      name: 'currentDevices',
      desc: '',
      args: [],
    );
  }

  /// `Thiết bị đã đăng nhập`
  String get historyDevices {
    return Intl.message(
      'Thiết bị đã đăng nhập',
      name: 'historyDevices',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản`
  String get account {
    return Intl.message(
      'Tài khoản',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Ứng dụng`
  String get app {
    return Intl.message(
      'Ứng dụng',
      name: 'app',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi thông tin`
  String get editProfile {
    return Intl.message(
      'Thay đổi thông tin',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Tên`
  String get name {
    return Intl.message(
      'Tên',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại`
  String get phone {
    return Intl.message(
      'Số điện thoại',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tháng năm sinh`
  String get dateOfBirth {
    return Intl.message(
      'Ngày tháng năm sinh',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Giới tính`
  String get gender {
    return Intl.message(
      'Giới tính',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Giới thiệu bản thân`
  String get bio {
    return Intl.message(
      'Giới thiệu bản thân',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật`
  String get update {
    return Intl.message(
      'Cập nhật',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi mật khẩu`
  String get changePassword {
    return Intl.message(
      'Thay đổi mật khẩu',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu hiện tại`
  String get currentPassword {
    return Intl.message(
      'Mật khẩu hiện tại',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mật khẩu mới`
  String get newPassword {
    return Intl.message(
      'Mật khẩu mới',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận mật khẩu mới`
  String get confirmNewPassword {
    return Intl.message(
      'Xác nhận mật khẩu mới',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật ảnh đại diện`
  String get updateAvatar {
    return Intl.message(
      'Cập nhật ảnh đại diện',
      name: 'updateAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Chụp ảnh`
  String get takeAPhoto {
    return Intl.message(
      'Chụp ảnh',
      name: 'takeAPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Lấy từ thư viện`
  String get pickFromGallery {
    return Intl.message(
      'Lấy từ thư viện',
      name: 'pickFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Đóng`
  String get cancel {
    return Intl.message(
      'Đóng',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Đã nhận`
  String get receive {
    return Intl.message(
      'Đã nhận',
      name: 'receive',
      desc: '',
      args: [],
    );
  }

  /// `Đã gửi`
  String get sent {
    return Intl.message(
      'Đã gửi',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu kết bạn`
  String get friendRequest {
    return Intl.message(
      'Yêu cầu kết bạn',
      name: 'friendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đăng xuất thất bại!`
  String get logOutFail {
    return Intl.message(
      'Đăng xuất thất bại!',
      name: 'logOutFail',
      desc: '',
      args: [],
    );
  }

  /// `Đang xác thực`
  String get verifying {
    return Intl.message(
      'Đang xác thực',
      name: 'verifying',
      desc: '',
      args: [],
    );
  }

  /// `Cảm ơn bạn đã xác thực email. Bạn hãy đăng nhập lại để tiếp tục bạn nhé!`
  String get thankForVerifyEmail {
    return Intl.message(
      'Cảm ơn bạn đã xác thực email. Bạn hãy đăng nhập lại để tiếp tục bạn nhé!',
      name: 'thankForVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Số điện thoại không hợp lệ`
  String get phoneNumberIsNotValid {
    return Intl.message(
      'Số điện thoại không hợp lệ',
      name: 'phoneNumberIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Nam`
  String get male {
    return Intl.message(
      'Nam',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Nữ`
  String get female {
    return Intl.message(
      'Nữ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Khác`
  String get other {
    return Intl.message(
      'Khác',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Hoàn tất`
  String get done {
    return Intl.message(
      'Hoàn tất',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Chọn giới tính`
  String get selectGender {
    return Intl.message(
      'Chọn giới tính',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi xảy ra trong quá trình Cập nhật thông tin! Vui lòng thử lại sau.`
  String get updateProfileFail {
    return Intl.message(
      'Đã có lỗi xảy ra trong quá trình Cập nhật thông tin! Vui lòng thử lại sau.',
      name: 'updateProfileFail',
      desc: '',
      args: [],
    );
  }

  /// `Cập nhật thông tin thành công`
  String get updateProfileSuccess {
    return Intl.message(
      'Cập nhật thông tin thành công',
      name: 'updateProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Đổi mật khẩu thành công`
  String get changePasswordSuccess {
    return Intl.message(
      'Đổi mật khẩu thành công',
      name: 'changePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Người dùng`
  String get user {
    return Intl.message(
      'Người dùng',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Kết bạn`
  String get addFriend {
    return Intl.message(
      'Kết bạn',
      name: 'addFriend',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu của bạn đã gửi thành công!`
  String get sendRequestSuccess {
    return Intl.message(
      'Yêu cầu của bạn đã gửi thành công!',
      name: 'sendRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Yêu cầu của bạn gửi thất bại! Vui lòng thử lại.`
  String get sendRequestFail {
    return Intl.message(
      'Yêu cầu của bạn gửi thất bại! Vui lòng thử lại.',
      name: 'sendRequestFail',
      desc: '',
      args: [],
    );
  }

  /// `Đang gửi`
  String get sending {
    return Intl.message(
      'Đang gửi',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `Chấp nhận lời mời thành công!`
  String get acceptRequestSuccess {
    return Intl.message(
      'Chấp nhận lời mời thành công!',
      name: 'acceptRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối yêu cầu thành công!`
  String get rejectRequestSuccess {
    return Intl.message(
      'Từ chối yêu cầu thành công!',
      name: 'rejectRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Thu hồi yêu cầu thành công!`
  String get undoRequestSuccess {
    return Intl.message(
      'Thu hồi yêu cầu thành công!',
      name: 'undoRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn chấp nhận lời mời kết bạn này không? Hãy đảm bảo bạn có quen biết người này.`
  String get doYouWantAcceptFriendRequest {
    return Intl.message(
      'Bạn có muốn chấp nhận lời mời kết bạn này không? Hãy đảm bảo bạn có quen biết người này.',
      name: 'doYouWantAcceptFriendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn từ chối lời mời kết bạn này hay không?`
  String get doYouWantRejectFriendRequest {
    return Intl.message(
      'Bạn có muốn từ chối lời mời kết bạn này hay không?',
      name: 'doYouWantRejectFriendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thu hồi lời mời kết bạn này hay không?`
  String get doYouWantUndoFriendRequest {
    return Intl.message(
      'Bạn có muốn thu hồi lời mời kết bạn này hay không?',
      name: 'doYouWantUndoFriendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập thất bại`
  String get loginFail {
    return Intl.message(
      'Đăng nhập thất bại',
      name: 'loginFail',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản hoặc mật khẩu sai`
  String get emailPasswordWrong {
    return Intl.message(
      'Tài khoản hoặc mật khẩu sai',
      name: 'emailPasswordWrong',
      desc: '',
      args: [],
    );
  }

  /// `Danh sách chặn`
  String get listUserBlock {
    return Intl.message(
      'Danh sách chặn',
      name: 'listUserBlock',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ chặn người dùng thành công`
  String get unBlockSuccess {
    return Intl.message(
      'Bỏ chặn người dùng thành công',
      name: 'unBlockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn bỏ chặn người dùng này hay không?`
  String get doYouWantUnBlockThisUser {
    return Intl.message(
      'Bạn có muốn bỏ chặn người dùng này hay không?',
      name: 'doYouWantUnBlockThisUser',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập hết hạn. Vui lòng đăng nhập lại!`
  String get loginInExpired {
    return Intl.message(
      'Đăng nhập hết hạn. Vui lòng đăng nhập lại!',
      name: 'loginInExpired',
      desc: '',
      args: [],
    );
  }

  /// `Chặn người dùng`
  String get block {
    return Intl.message(
      'Chặn người dùng',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Xóa kết bạn`
  String get removeFriend {
    return Intl.message(
      'Xóa kết bạn',
      name: 'removeFriend',
      desc: '',
      args: [],
    );
  }

  /// `Thu hồi lời mời kết bạn`
  String get undoFriendRequest {
    return Intl.message(
      'Thu hồi lời mời kết bạn',
      name: 'undoFriendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Xóa kết bạn thành công!`
  String get unFriendSuccess {
    return Intl.message(
      'Xóa kết bạn thành công!',
      name: 'unFriendSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Chặn người dùng thành công!`
  String get blockSuccess {
    return Intl.message(
      'Chặn người dùng thành công!',
      name: 'blockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tải hình ảnh lên thành công!`
  String get uploadImageSuccess {
    return Intl.message(
      'Tải hình ảnh lên thành công!',
      name: 'uploadImageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tải hình ảnh lên thất bại! Vui lòng thử lại`
  String get uploadImageFail {
    return Intl.message(
      'Tải hình ảnh lên thất bại! Vui lòng thử lại',
      name: 'uploadImageFail',
      desc: '',
      args: [],
    );
  }

  /// `Lời mời nhóm`
  String get groupRequest {
    return Intl.message(
      'Lời mời nhóm',
      name: 'groupRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đang tải`
  String get loading {
    return Intl.message(
      'Đang tải',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Hình ảnh`
  String get image {
    return Intl.message(
      'Hình ảnh',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Tệp tin`
  String get file {
    return Intl.message(
      'Tệp tin',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `Vị trí`
  String get location {
    return Intl.message(
      'Vị trí',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Mở vị trí`
  String get openLocation {
    return Intl.message(
      'Mở vị trí',
      name: 'openLocation',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản hoặc mật khẩu sai! Vui lòng thử lại.`
  String get emailOrPasswordWrong {
    return Intl.message(
      'Tài khoản hoặc mật khẩu sai! Vui lòng thử lại.',
      name: 'emailOrPasswordWrong',
      desc: '',
      args: [],
    );
  }

  /// `Tham gia`
  String get join {
    return Intl.message(
      'Tham gia',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Gửi tin nhắn emoji hoặc loại tin nhắn khác`
  String get sendMediaOrEmojiMessage {
    return Intl.message(
      'Gửi tin nhắn emoji hoặc loại tin nhắn khác',
      name: 'sendMediaOrEmojiMessage',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Thư viện ảnh`
  String get gallery {
    return Intl.message(
      'Thư viện ảnh',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Âm thanh`
  String get voice {
    return Intl.message(
      'Âm thanh',
      name: 'voice',
      desc: '',
      args: [],
    );
  }

  /// `Tệp`
  String get files {
    return Intl.message(
      'Tệp',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Stickers`
  String get stickers {
    return Intl.message(
      'Stickers',
      name: 'stickers',
      desc: '',
      args: [],
    );
  }

  /// `Vị trí hiện tại`
  String get currentLocation {
    return Intl.message(
      'Vị trí hiện tại',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Kích thước file không được quá {size} mb! Vui lòng thử lại`
  String fileLimitSize(String size) {
    return Intl.message(
      'Kích thước file không được quá $size mb! Vui lòng thử lại',
      name: 'fileLimitSize',
      desc: '',
      args: [size],
    );
  }

  /// `Ứng dụng không có quyền để thực hiện tính năng này. Vui lòng cấp quyền cho ứng dụng`
  String get appDontHavePermission {
    return Intl.message(
      'Ứng dụng không có quyền để thực hiện tính năng này. Vui lòng cấp quyền cho ứng dụng',
      name: 'appDontHavePermission',
      desc: '',
      args: [],
    );
  }

  /// `Gửi vị trí`
  String get sendMyLocation {
    return Intl.message(
      'Gửi vị trí',
      name: 'sendMyLocation',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập thành công`
  String get loginSuccess {
    return Intl.message(
      'Đăng nhập thành công',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhóm`
  String get createGroup {
    return Intl.message(
      'Tạo nhóm',
      name: 'createGroup',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhóm thành công`
  String get createGroupSuccess {
    return Intl.message(
      'Tạo nhóm thành công',
      name: 'createGroupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhóm thất bại`
  String get createGroupFail {
    return Intl.message(
      'Tạo nhóm thất bại',
      name: 'createGroupFail',
      desc: '',
      args: [],
    );
  }

  /// `Tên nhóm`
  String get groupName {
    return Intl.message(
      'Tên nhóm',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `Thành viên`
  String get members {
    return Intl.message(
      'Thành viên',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Đã chọn`
  String get selected {
    return Intl.message(
      'Đã chọn',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thoát khỏi trang này?`
  String get doYouWantToExit {
    return Intl.message(
      'Bạn có muốn thoát khỏi trang này?',
      name: 'doYouWantToExit',
      desc: '',
      args: [],
    );
  }

  /// `Tên nhóm không được để trống`
  String get groupNameCannotBeEmpty {
    return Intl.message(
      'Tên nhóm không được để trống',
      name: 'groupNameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Tạo`
  String get create {
    return Intl.message(
      'Tạo',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Đã có lỗi xảy ra! Vui lòng thử lại.`
  String get someThingWrong {
    return Intl.message(
      'Đã có lỗi xảy ra! Vui lòng thử lại.',
      name: 'someThingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy yêu cầu! Vui lòng kiểm tra lại.`
  String get requestNotFound {
    return Intl.message(
      'Không tìm thấy yêu cầu! Vui lòng kiểm tra lại.',
      name: 'requestNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chung`
  String get friendCommon {
    return Intl.message(
      'Bạn chung',
      name: 'friendCommon',
      desc: '',
      args: [],
    );
  }

  /// `Nhóm chung`
  String get groupCommon {
    return Intl.message(
      'Nhóm chung',
      name: 'groupCommon',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn huỷ kết bạn?`
  String get doYouWantUnFriend {
    return Intl.message(
      'Bạn có muốn huỷ kết bạn?',
      name: 'doYouWantUnFriend',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã gửi yêu cầu trước đây? Vì vậy bạn không thể gửi thêm yêu cầu này nữa.`
  String get youHaveAlreadySentThisRequest {
    return Intl.message(
      'Bạn đã gửi yêu cầu trước đây? Vì vậy bạn không thể gửi thêm yêu cầu này nữa.',
      name: 'youHaveAlreadySentThisRequest',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý/ Từ chối`
  String get acceptOrReject {
    return Intl.message(
      'Đồng ý/ Từ chối',
      name: 'acceptOrReject',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc chắn muốn chặn người này?`
  String get areYouSureBlockThisUser {
    return Intl.message(
      'Bạn có chắc chắn muốn chặn người này?',
      name: 'areYouSureBlockThisUser',
      desc: '',
      args: [],
    );
  }

  /// `Bỏ chặn`
  String get unBlock {
    return Intl.message(
      'Bỏ chặn',
      name: 'unBlock',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa`
  String get edit {
    return Intl.message(
      'Chỉnh sửa',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Chỉnh sửa nhóm`
  String get editGroup {
    return Intl.message(
      'Chỉnh sửa nhóm',
      name: 'editGroup',
      desc: '',
      args: [],
    );
  }

  /// `Xem hình ảnh, video, tệp tin`
  String get seePictureVideosFiles {
    return Intl.message(
      'Xem hình ảnh, video, tệp tin',
      name: 'seePictureVideosFiles',
      desc: '',
      args: [],
    );
  }

  /// `Rời nhóm`
  String get leaveGroup {
    return Intl.message(
      'Rời nhóm',
      name: 'leaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Hành động khác`
  String get moreAction {
    return Intl.message(
      'Hành động khác',
      name: 'moreAction',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin`
  String get information {
    return Intl.message(
      'Thông tin',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Chia sẻ màn hình`
  String get screenSharing {
    return Intl.message(
      'Chia sẻ màn hình',
      name: 'screenSharing',
      desc: '',
      args: [],
    );
  }

  /// `{appName} đang chia sẻ màn hình.`
  String isSharingTheScreen(String appName) {
    return Intl.message(
      '$appName đang chia sẻ màn hình.',
      name: 'isSharingTheScreen',
      desc: '',
      args: [appName],
    );
  }

  /// `Đã trở thành bạn bè`
  String get becomeFriend {
    return Intl.message(
      'Đã trở thành bạn bè',
      name: 'becomeFriend',
      desc: '',
      args: [],
    );
  }

  /// `Nhóm được tạo`
  String get roomCreated {
    return Intl.message(
      'Nhóm được tạo',
      name: 'roomCreated',
      desc: '',
      args: [],
    );
  }

  /// `Tham gia nhóm`
  String get memberJoined {
    return Intl.message(
      'Tham gia nhóm',
      name: 'memberJoined',
      desc: '',
      args: [],
    );
  }

  /// `Rời nhóm`
  String get memberLeft {
    return Intl.message(
      'Rời nhóm',
      name: 'memberLeft',
      desc: '',
      args: [],
    );
  }

  /// `Bắt đầu cuộc gọi`
  String get callStarted {
    return Intl.message(
      'Bắt đầu cuộc gọi',
      name: 'callStarted',
      desc: '',
      args: [],
    );
  }

  /// `Cuộc gọi kết thúc`
  String get callEnded {
    return Intl.message(
      'Cuộc gọi kết thúc',
      name: 'callEnded',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn rời khỏi nhóm này không?`
  String get doYouWantToLeaveThisGroup {
    return Intl.message(
      'Bạn có muốn rời khỏi nhóm này không?',
      name: 'doYouWantToLeaveThisGroup',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn xóa thiết bị này hay không?`
  String get doYouWantDeleteDevice {
    return Intl.message(
      'Bạn có muốn xóa thiết bị này hay không?',
      name: 'doYouWantDeleteDevice',
      desc: '',
      args: [],
    );
  }

  /// `Xóa thiết bị mới thành công`
  String get deleteDeviceSuccess {
    return Intl.message(
      'Xóa thiết bị mới thành công',
      name: 'deleteDeviceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Xóa thiết bị thất bại`
  String get deleteDeviceFail {
    return Intl.message(
      'Xóa thiết bị thất bại',
      name: 'deleteDeviceFail',
      desc: '',
      args: [],
    );
  }

  /// `Gửi lời mời vào nhóm thất bại. {name} đã được mời trước đó.`
  String sendGroupRequestFail(String name) {
    return Intl.message(
      'Gửi lời mời vào nhóm thất bại. $name đã được mời trước đó.',
      name: 'sendGroupRequestFail',
      desc: '',
      args: [name],
    );
  }

  /// `Thành công`
  String get success {
    return Intl.message(
      'Thành công',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Xem thông tin cá nhân`
  String get seeProfile {
    return Intl.message(
      'Xem thông tin cá nhân',
      name: 'seeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Tạo nhóm Chat với {name}`
  String createGroupWith(String name) {
    return Intl.message(
      'Tạo nhóm Chat với $name',
      name: 'createGroupWith',
      desc: '',
      args: [name],
    );
  }

  /// `Xóa kết bạn`
  String get deleteFriend {
    return Intl.message(
      'Xóa kết bạn',
      name: 'deleteFriend',
      desc: '',
      args: [],
    );
  }

  /// `Phản hồi tin nhắn`
  String get repliedMessage {
    return Intl.message(
      'Phản hồi tin nhắn',
      name: 'repliedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Phản hồi`
  String get reply {
    return Intl.message(
      'Phản hồi',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Phòng chat`
  String get chatRoom {
    return Intl.message(
      'Phòng chat',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn xóa toàn bộ thông báo?`
  String get doYouWantToDeleteAllNotifications {
    return Intl.message(
      'Bạn có muốn xóa toàn bộ thông báo?',
      name: 'doYouWantToDeleteAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn xóa thông báo này hay không?`
  String get doYouWantToDeleteThisNotification {
    return Intl.message(
      'Bạn có muốn xóa thông báo này hay không?',
      name: 'doYouWantToDeleteThisNotification',
      desc: '',
      args: [],
    );
  }

  /// `Xóa thông báo`
  String get deleteNotification {
    return Intl.message(
      'Xóa thông báo',
      name: 'deleteNotification',
      desc: '',
      args: [],
    );
  }

  /// `Sao chép`
  String get copy {
    return Intl.message(
      'Sao chép',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Đã sao chép`
  String get copied {
    return Intl.message(
      'Đã sao chép',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển tiếp`
  String get forward {
    return Intl.message(
      'Chuyển tiếp',
      name: 'forward',
      desc: '',
      args: [],
    );
  }

  /// `Gửi`
  String get send {
    return Intl.message(
      'Gửi',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Thay đổi tên nhóm`
  String get changeGroupName {
    return Intl.message(
      'Thay đổi tên nhóm',
      name: 'changeGroupName',
      desc: '',
      args: [],
    );
  }

  /// `Tin nhắn`
  String get messenger {
    return Intl.message(
      'Tin nhắn',
      name: 'messenger',
      desc: '',
      args: [],
    );
  }

  /// `Tin nhắn chuyển tiếp`
  String get forwardMessage {
    return Intl.message(
      'Tin nhắn chuyển tiếp',
      name: 'forwardMessage',
      desc: '',
      args: [],
    );
  }

  /// `Chuyển tiếp tin nhắn thành công`
  String get forwardMessageSuccess {
    return Intl.message(
      'Chuyển tiếp tin nhắn thành công',
      name: 'forwardMessageSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Nếu bạn có nhu cầu liên hệ hoặc báo các vấn đề, lỗi phát sinh khi dùng ứng dụng, vui lòng liên hệ đến địa chỉ Email sau: `
  String get contact_message {
    return Intl.message(
      'Nếu bạn có nhu cầu liên hệ hoặc báo các vấn đề, lỗi phát sinh khi dùng ứng dụng, vui lòng liên hệ đến địa chỉ Email sau: ',
      name: 'contact_message',
      desc: '',
      args: [],
    );
  }

  /// `Không thể mở ứng dụng Mail. Vui lòng thử lại!`
  String get openEmailFail {
    return Intl.message(
      'Không thể mở ứng dụng Mail. Vui lòng thử lại!',
      name: 'openEmailFail',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt nâng cao`
  String get settingAdvanced {
    return Intl.message(
      'Cài đặt nâng cao',
      name: 'settingAdvanced',
      desc: '',
      args: [],
    );
  }

  /// `Ngày tạo`
  String get createdDate {
    return Intl.message(
      'Ngày tạo',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Được tạo bởi`
  String get createdBy {
    return Intl.message(
      'Được tạo bởi',
      name: 'createdBy',
      desc: '',
      args: [],
    );
  }

  /// `Phiên hoạt động`
  String get activeSession {
    return Intl.message(
      'Phiên hoạt động',
      name: 'activeSession',
      desc: '',
      args: [],
    );
  }

  /// `Người dùng bạn có thể quen`
  String get recommendedUser {
    return Intl.message(
      'Người dùng bạn có thể quen',
      name: 'recommendedUser',
      desc: '',
      args: [],
    );
  }

  /// `Tài khoản đã tồn tại`
  String get accountExist {
    return Intl.message(
      'Tài khoản đã tồn tại',
      name: 'accountExist',
      desc: '',
      args: [],
    );
  }

  /// `Email này đã được sử dụng! Vui lòng đăng ký với một email khác.`
  String get emailUsedByOtherAccount {
    return Intl.message(
      'Email này đã được sử dụng! Vui lòng đăng ký với một email khác.',
      name: 'emailUsedByOtherAccount',
      desc: '',
      args: [],
    );
  }

  /// `Mở ứng dụng Mail`
  String get openMailApp {
    return Intl.message(
      'Mở ứng dụng Mail',
      name: 'openMailApp',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy ứng dụng Mail nào! Vui lòng kiểm tra lại`
  String get noMailAppInstalled {
    return Intl.message(
      'Không tìm thấy ứng dụng Mail nào! Vui lòng kiểm tra lại',
      name: 'noMailAppInstalled',
      desc: '',
      args: [],
    );
  }

  /// `Người nhận`
  String get receiver {
    return Intl.message(
      'Người nhận',
      name: 'receiver',
      desc: '',
      args: [],
    );
  }

  /// `Người gửi`
  String get sender {
    return Intl.message(
      'Người gửi',
      name: 'sender',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn từ chối lời mời tham gia group này?`
  String get doYouWantRejectGroupRequest {
    return Intl.message(
      'Bạn có muốn từ chối lời mời tham gia group này?',
      name: 'doYouWantRejectGroupRequest',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn tham gia nhóm này hay không?`
  String get doYouWantJoinGroupRequest {
    return Intl.message(
      'Bạn có muốn tham gia nhóm này hay không?',
      name: 'doYouWantJoinGroupRequest',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có muốn thu hồi lời mời tham gia nhóm này hay không?`
  String get doYouWantUndoGroupRequest {
    return Intl.message(
      'Bạn có muốn thu hồi lời mời tham gia nhóm này hay không?',
      name: 'doYouWantUndoGroupRequest',
      desc: '',
      args: [],
    );
  }

  /// `Nhập tin nhắn`
  String get typeAMessage {
    return Intl.message(
      'Nhập tin nhắn',
      name: 'typeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống sẽ tiến hành đăng xuất. Bạn hãy đăng nhập lại để tiếp tục nhé!`
  String get reLoginToContinue {
    return Intl.message(
      'Hệ thống sẽ tiến hành đăng xuất. Bạn hãy đăng nhập lại để tiếp tục nhé!',
      name: 'reLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Nhóm`
  String get group {
    return Intl.message(
      'Nhóm',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Không tìm thấy người dùng`
  String get userNotFound {
    return Intl.message(
      'Không tìm thấy người dùng',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Rời nhóm thành công`
  String get leaveGroupSuccess {
    return Intl.message(
      'Rời nhóm thành công',
      name: 'leaveGroupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Thông tin nhóm`
  String get groupInfo {
    return Intl.message(
      'Thông tin nhóm',
      name: 'groupInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tắt Camera`
  String get disableCamera {
    return Intl.message(
      'Tắt Camera',
      name: 'disableCamera',
      desc: '',
      args: [],
    );
  }

  /// `Chọn Camera`
  String get selectCamera {
    return Intl.message(
      'Chọn Camera',
      name: 'selectCamera',
      desc: '',
      args: [],
    );
  }

  /// `Chọn kích thước Video`
  String get selectVideoDimension {
    return Intl.message(
      'Chọn kích thước Video',
      name: 'selectVideoDimension',
      desc: '',
      args: [],
    );
  }

  /// `Tắt Microphone`
  String get disableMicrophone {
    return Intl.message(
      'Tắt Microphone',
      name: 'disableMicrophone',
      desc: '',
      args: [],
    );
  }

  /// `Chọn Microphone`
  String get selectMicrophone {
    return Intl.message(
      'Chọn Microphone',
      name: 'selectMicrophone',
      desc: '',
      args: [],
    );
  }

  /// `Kết thúc cuộc gọi`
  String get disconnect {
    return Intl.message(
      'Kết thúc cuộc gọi',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Bạn có chắc muốn kết thúc cuộc gọi?`
  String get areYouSureDisconnect {
    return Intl.message(
      'Bạn có chắc muốn kết thúc cuộc gọi?',
      name: 'areYouSureDisconnect',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối lại`
  String get reconnect {
    return Intl.message(
      'Kết nối lại',
      name: 'reconnect',
      desc: '',
      args: [],
    );
  }

  /// `Kết nối lại thành công.`
  String get reconnectSuccess {
    return Intl.message(
      'Kết nối lại thành công.',
      name: 'reconnectSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống buộc kết nối lại`
  String get thisWillForceReconnect {
    return Intl.message(
      'Hệ thống buộc kết nối lại',
      name: 'thisWillForceReconnect',
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

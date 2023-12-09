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

  /// `Theme and Language`
  String get themeAndLanguage {
    return Intl.message(
      'Theme and Language',
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

  /// `Về chún tôi`
  String get about {
    return Intl.message(
      'Về chún tôi',
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

  /// `Tệp`
  String get file {
    return Intl.message(
      'Tệp',
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

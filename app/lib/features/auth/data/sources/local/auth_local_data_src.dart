import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken({required String token, String? refreshToken});

  Future<void> clearToken();

  Future<AppObjResultRaw<TokenRaw>> getToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  late final AppSharedPref _pref;

  AuthLocalDataSourceImpl(this._pref) {
    _pref.onInit();
  }

  @override
  Future<void> saveToken({required String token, String? refreshToken}) async {
    await _pref.setString(AppPrefKey.token, token);
    if (refreshToken != null) {
      await _pref.setString(AppPrefKey.refreshToken, refreshToken);
    }
  }

  @override
  Future<void> clearToken() async {
    await _pref.deleteValue(AppPrefKey.token);
    await _pref.deleteValue(AppPrefKey.refreshToken);
  }

  @override
  Future<AppObjResultRaw<TokenRaw>> getToken() {
    final token = _pref.getString(AppPrefKey.token, '');
    final refreshToken = _pref.getString(AppPrefKey.refreshToken, '');
    return Future.value(AppObjResultRaw(
        netData: TokenRaw(accessToken: token, refreshToken: refreshToken)));
  }
}

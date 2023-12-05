import 'package:app/features/user/data/resources/local/user_local_data_src.dart';
import 'package:app/features/user/data/resources/remote/user_remote_data_src.dart';
import 'package:app/features/user/domain/repositories/user_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  late final UserRemoteDataSource _userRemoteDataSource;
  late final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._userLocalDataSource);

  @override
  Future<AppObjResultModel<UserModel>> getUserSelf() async {
    try {
      final response = await _userRemoteDataSource.getSelfInfo();
      if (response.netData != null) {
        await _userLocalDataSource.updateUserInfo(response.netData!);
      }
      return response.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<EmptyModel>> updateUserProfile(
      {required Map<String, dynamic> body}) async {
    try {
      body.removeWhere((key, value) => value == null || value == "");
      await _userRemoteDataSource.updateSelfInfo(body: body);
      await getUserSelf();
      return AppObjResultModel(netData: EmptyModel());
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppObjResultModel<UserModel>> getUserSelfFromLocal() async {
    try {
      final response = await _userLocalDataSource.getUserInfo();

      if (response == null) {
        return AppObjResultModel(netData: UserModel(id: '-1'));
      } else {
        return AppObjResultModel(netData: response.raw2Model());
      }
    } on AppException catch (_) {
      rethrow;
    }
  }

  @override
  Stream<UserModel?> getUserLocalStream() {
    return _userLocalDataSource.getUserStream().map((userRaw) {
      return userRaw?.raw2Model();
    });
  }

  @override
  Future<AppObjResultModel<UserModel>> getUserById(
      {required Map<String, dynamic> request}) async {
    try {
      final response = await _userRemoteDataSource.getUserById(query: request);
      return response.raw2Model();
    } on AppException catch (_) {
      rethrow;
    }
  }
}

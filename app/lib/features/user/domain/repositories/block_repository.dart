import 'package:domain/domain.dart';

abstract class BlockRepository {
  Future<AppListResultModel<UserModel>> getListUserBlock();

  Future<AppObjResultModel<EmptyModel>> blockUser(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> unBlockUser(
      {required Map<String, dynamic> query});
}

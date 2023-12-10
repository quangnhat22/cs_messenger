import 'package:domain/domain.dart';

abstract class GroupRepository {
  Future<AppListResultModel<GroupModel>> getListGroup(
      {required Map<String, dynamic> query});

  Future<AppObjResultModel<EmptyModel>> createNewGroup(
      {required Map<String, dynamic> request});
}

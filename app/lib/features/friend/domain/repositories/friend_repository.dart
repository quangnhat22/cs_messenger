import 'package:domain/domain.dart';

abstract class FriendRepository {
  Future<AppListResultModel<HistoryCallModel>> getListCallHistory(
      {required Map<String, dynamic> query});

  Future<AppListResultModel<UserModel>> getListFriend(
      {required Map<String, dynamic> query});
}

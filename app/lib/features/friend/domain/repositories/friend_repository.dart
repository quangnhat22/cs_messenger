import 'package:domain/domain.dart';

abstract class FriendRepository {
  Future<AppListResultModel<HistoryCallModel>> getListCallHistory(
      {required Map<String, dynamic> query});
}

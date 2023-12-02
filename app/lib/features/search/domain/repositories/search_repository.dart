import 'package:domain/domain.dart';

abstract class SearchRepository {
  Future<AppObjResultModel<SearchModel>> search(
      {required Map<String, dynamic> query});
}

part of 'base_model.dart';

class AppListResultModel<BM extends BaseModel> {
  AppListResultModel({
    required this.netData,
    this.hasMore = false,
    this.total = 0,
    this.next,
    this.before,
  });

  final List<BM>? netData;
  final bool hasMore;
  final int total;
  final String? next;
  final String? before;
}

class AppObjResultModel<BM extends BaseModel> {
  AppObjResultModel({required this.netData});

  final BM? netData;
}

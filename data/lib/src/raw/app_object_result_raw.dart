part of 'base_raw.dart';

class AppListResultRaw<BR extends BaseRaw> {
  AppListResultRaw({
    required this.netData,
    this.hasMore = false,
    this.total = 0,
    this.next,
    this.before,
  });

  final List<BR>? netData;
  final bool hasMore;
  final int total;
  final String? next;
  final String? before;

  AppListResultModel<BM> raw2Model<BM extends BaseModel>() =>
      AppListResultModel(
        netData: netData?.map((e) => e.raw2Model() as BM).toList(),
        hasMore: hasMore,
        total: total,
        next: next,
        before: before,
      );
}

class AppObjResultRaw<BR extends BaseRaw> {
  AppObjResultRaw({required this.netData});

  final BR? netData;

  AppObjResultModel<BM> raw2Model<BM extends BaseModel>() =>
      AppObjResultModel(netData: netData?.raw2Model() as BM?);
}

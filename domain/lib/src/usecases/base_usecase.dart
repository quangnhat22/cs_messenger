part of domain;

abstract class BaseUseCase<In extends BaseParam, Out extends BaseModel> {
  Future<AppObjResultModel<Out>> executeObj({In? request}) {
    return Future.value(AppObjResultModel<Out>(netData: null));
  }

  Future<AppListResultModel<Out>> executeList({In? request}) {
    return Future.value(
        AppListResultModel<Out>(netData: null, total: 0, hasMore: false));
  }
}

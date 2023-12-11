import 'package:app/components/features/skeleton/list_skeletion.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:resources/resources.dart';

class AppListWidget<BM extends BaseModel, BS extends AppListViewState<BM>,
    BC extends Cubit<BS>> extends StatelessWidget {
  AppListWidget({
    required this.childWidget,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.emptyView,
    this.retryView,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext, BM model, int index) childWidget;
  final Widget? emptyView;
  final Widget? retryView;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? scrollController;
  final ScrollPhysics physics;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BC, BS>(
      builder: (BuildContext ctx, BS state) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const MaterialClassicHeader(),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(ctx),
          onLoading: () => _onLoadMore(ctx),
          child: state.appException != null
              ? _retry(ctx)
              : _main(ctx, state.data, state.isLoading),
        );
      },
    );
  }

  Widget _main(BuildContext context, List<BM> data, bool isLoading) {
    return isLoading
        ? const ListSkeleton()
        : data.isEmpty
            ? Center(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: R.svgs.icNoData.svg(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: scrollDirection,
                reverse: reverse,
                physics: physics,
                itemCount: data.length,
                itemBuilder: (ctx, index) => childWidget.call(
                  ctx,
                  data[index],
                  index,
                ),
              );
  }

  Widget _retry(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorPaddingScale(6),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: retryView ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  R.svgs.icErrorList.svg(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: MediaQuery.sizeOf(context).width * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizeExt.of.majorPaddingScale(5),
                    ),
                    child: AppTextHeadlineSmallWidget()
                        .setText(R.strings.someThingWrong)
                        .setColor(Theme.of(context).colorScheme.tertiary)
                        .setTextAlign(TextAlign.center)
                        .build(context),
                  ),
                  AppButtonOutlineWidget()
                      .setButtonText(R.strings.retry)
                      .setBorderColor(Theme.of(context).colorScheme.error)
                      .setTextStyle(
                          TextStyle(color: Theme.of(context).colorScheme.error))
                      .setOnPressed(() =>
                          context.read<AppListViewCubit<BM>>().initFetch())
                      .build(context),
                ],
              ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) async {
    await (context.read<BC>() as AppListViewCubit).onRefreshCall();
    // Always allow pull to refresh
    _refreshController.refreshToIdle();
  }

  void _onLoadMore(BuildContext context) async {
    final hasMore = context.read<BC>().state.hasMore;
    if (!hasMore) {
      return _refreshController.loadComplete();
    }
    await (context.read<BC>() as AppListViewCubit).onLoadMoreCall();
    _refreshController.loadComplete();
  }
}

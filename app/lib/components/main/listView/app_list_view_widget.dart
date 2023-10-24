import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/components/main/listView/controllers/app_list_view_cubit.dart';
import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:app/configs/di/di.dart';
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
    return BlocProvider(
      create: (context) => getIt<BC>(),
      child: BlocBuilder<BC, BS>(
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
                : _main(ctx, state.data),
          );
        },
      ),
    );
  }

  Widget _main(BuildContext context, List<BM> data) {
    return data.isEmpty
        ? emptyView ??
            Center(
                child: AppTextBodyMediumWidget()
                    .setText(R.strings.friends)
                    .setTextAlign(TextAlign.center)
                    .build(context))
        : ListView.builder(
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
    return retryView ??
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(4)),
              child: AppTextHeadlineSmallWidget()
                  .setText(R.strings.serverError)
                  .setTextAlign(TextAlign.center)
                  .build(context),
            ),
            AppButtonFilledWidget()
                .setButtonText(R.strings.retry)
                .setOnPressed(
                    () => context.read<AppListViewCubit<BM>>().initFetch())
                .build(context),
          ],
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

part of 'app_tab_base_builder.dart';

class AppTapBarWidget extends AppTabBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_routes == null) {
      throw FormatException(R.strings.invalidInput);
    }

    return AutoTabsRouter.tabBar(
      routes: _routes!,
      builder: (context, childView, tabController) {
        return Column(
          children: [
            SizedBox(
              height: AppSizeExt.of.majorScale(1),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.16),
                      borderRadius:
                          BorderRadius.circular(AppSizeExt.of.majorScale(8)),
                    ),
                    child: TabBar(
                      controller: tabController,
                      tabs: _labels!.map((label) {
                        final index = _labels!.indexOf(label);
                        return _buildTabContainer(
                            context, index == tabController.index, index);
                      }).toList(),
                      indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppSizeExt.of.majorScale(8)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      splashFactory: NoSplash.splashFactory,
                      labelPadding: EdgeInsets.symmetric(
                        vertical: AppSizeExt.of.majorPaddingScale(2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSizeExt.of.majorScale(2),
                  ),
                  Expanded(child: childView)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContainer(BuildContext context, bool isSelected, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeExt.of.majorScale(10),
        vertical: AppSizeExt.of.majorScale(2 / 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextBodyMediumWidget()
              .setText(_labels![index])
              .setColor(
                  isSelected ? Theme.of(context).colorScheme.background : null)
              .build(context),
          if (_numbers?[index] != null && _numbers![index] != 0)
            SizedBox(width: AppSizeExt.of.majorScale(4)),
          if (_numbers?[index] != null && _numbers![index] != 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeExt.of.majorScale(100)),
                ),
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizeExt.of.majorPaddingScale(8 / 4),
                  vertical: AppSizeExt.of.majorPaddingScale(1 / 4),
                ),
                child: Center(
                  child: AppTextBodyMediumWidget()
                      .setText(_numbers![index].toString())
                      .setColor(Theme.of(context).colorScheme.secondary)
                      .build(context),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  AppTapBarWidget setRoutes(List<PageRouteInfo>? routes) {
    _routes = routes;
    return this;
  }

  @override
  AppTapBarWidget setNumbers(List<int>? numbers) {
    if (numbers?.length != _routes?.length) {
      throw const FormatException("Length numbers not match");
    }
    _numbers = numbers;
    return this;
  }

  @Deprecated('Not working in this version!')
  @override
  AppTapBarWidget setIcons(List<Widget>? icons) {
    if (icons?.length != _routes?.length) {
      throw const FormatException("Length numbers not match");
    }
    _icons = icons;
    return this;
  }

  @override
  AppTapBarWidget setLabels(List<String>? labels) {
    if (labels?.length != _routes?.length) {
      throw const FormatException("Length labels not match");
    }
    _labels = labels;
    return this;
  }
}

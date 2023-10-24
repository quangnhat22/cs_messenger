part of 'app_tab_base_builder.dart';

class AppBottomTabBuilder extends AppTabBaseBuilder {
  @override
  Widget build(BuildContext context) {
    if (_routes == null) {
      throw FormatException(R.strings.invalidInput);
    }

    return AutoTabsRouter(
      routes: _routes!,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (value) {
              tabsRouter.setActiveIndex(value);
            },
            destinations: _labels!.map((label) {
              final index = _labels!.indexOf(label);
              return _buildDestination(context, index);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildDestination(BuildContext context, int index) {
    return NavigationDestination(
      icon: _icons![index],
      label: _labels![index],
    );
  }

  @override
  AppBottomTabBuilder setRoutes(List<PageRouteInfo<dynamic>>? routes) {
    _routes = routes;
    return this;
  }

  @Deprecated('Not working in this version!')
  @override
  AppBottomTabBuilder setNumbers(List<int>? numbers) {
    if (numbers?.length != _routes?.length) {
      throw const FormatException("Length numbers not match");
    }
    _numbers = numbers;
    return this;
  }

  @override
  AppBottomTabBuilder setIcons(List<Widget>? icons) {
    if (icons?.length != _routes?.length) {
      throw const FormatException("Length numbers not match");
    }
    _icons = icons;
    return this;
  }

  @override
  AppTabBaseBuilder setLabels(List<String>? labels) {
    if (labels?.length != _routes?.length) {
      throw const FormatException("Length labels not match");
    }
    _labels = labels;
    return this;
  }
}

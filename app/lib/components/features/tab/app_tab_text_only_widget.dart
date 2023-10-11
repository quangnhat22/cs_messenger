part of 'app_tab_base_builder.dart';

class AppTabTextOnlyWidget extends AppTabBaseBuilder {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  AppTabBaseBuilder setTabDefaultIconList(List<Widget> tabDefaultIconList) {
    _tabDefaultIconList = tabDefaultIconList;
    return this;
  }

  @override
  AppTabBaseBuilder setTabNumberList(List<String> tabNumberList) {
    _tabTitleList = tabNumberList;
    return this;
  }

  @override
  AppTabBaseBuilder setTabTitleList(List<String> tabTitleList) {
    _tabTitleList = tabTitleList;
    return this;
  }

  @override
  AppTabBaseBuilder setTabViewList(List<Widget> tabViewList) {
    _tabViewList = tabViewList;
    return this;
  }
}

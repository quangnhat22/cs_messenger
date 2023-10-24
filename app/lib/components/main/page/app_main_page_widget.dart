part of 'app_main_page_base_builder.dart';

class AppMainPageWidget extends AppMainPageBaseBuilder {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor:
              _backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
          appBar: _appBar,
          endDrawer: _endDrawer,
          endDrawerEnableOpenDragGesture: false,
          onEndDrawerChanged: _onEndDrawerChanged,
          resizeToAvoidBottomInset: _resizeToAvoidBottomInset ?? false,
          body: _body ?? const SizedBox(),
          floatingActionButton: _floatActionButton,
        ),
      ),
    );
  }

  @override
  AppMainPageWidget setBackgroundColor(Color? backgroundColor) {
    _backgroundColor = backgroundColor;
    return this;
  }

  @override
  AppMainPageWidget setBody(Widget? body) {
    _body = body;
    return this;
  }

  @override
  AppMainPageWidget setEndDrawer(Widget? endDrawer) {
    _endDrawer = endDrawer;
    return this;
  }

  @override
  AppMainPageWidget setEndDrawerChanged(
      void Function(bool p1)? onEndDrawerChanged) {
    _onEndDrawerChanged = onEndDrawerChanged;
    return this;
  }

  @override
  AppMainPageWidget setKey(Key? key) {
    _key = key;
    return this;
  }

  @override
  AppMainPageWidget setAppBar(PreferredSizeWidget? appBar) {
    _appBar = appBar;
    return this;
  }

  @override
  AppMainPageWidget setResizeToAvoidBottomInset(
      bool? resizeToAvoidBottomInset) {
    _resizeToAvoidBottomInset = resizeToAvoidBottomInset;
    return this;
  }

  @override
  AppMainPageWidget setFloatActionButton(Widget? floatActionButton) {
    _floatActionButton = floatActionButton;
    return this;
  }
}
